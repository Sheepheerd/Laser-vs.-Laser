extends Node2D

class ButtonSprite extends Sprite2D:
	var metadata: int

#The Buttons That will be displayed, add duplicates to enable the randomness.
var originalButtonInputs = ["Up_dir", "Down_dir", "Up_dir", "Down_dir"]
var shuffledButtonInputs = []  # Holds the shuffled button inputs for each combat phase

#Button Index
var currentInputIndex = 0

#If enabled, then will proceed with Button Input Phase
var shouldCheckInput = false
var shouldCollisionEnable = false
# Defining Signal
signal player_attack

signal combat_phase_success
signal combat_phase_fail

#Defining If the player has attacked so that it can end the timer in BowTiming.gd
var has_attacked = false

#Define the correctnessPercent
var correctnessPercent = 0

#Define DamageMultiplier Var
var DamageMultiplier = 0.0
var damage = 0.0
var has_done_d_calc = false
var finalDamage = 0.0
var adjustedDamage = 0.0

#Fix This Later - This should be dependant on the weapon of the user/level
var BaseDamage = 0.0

# Placeholder For Attack
var has_done_damage = false

func _ui_range_attack():
	var UI = get_node("/root/AttackScene/UI")
	if UI.current_game_state == UI.GameState.PLAYER_ATTACKING && get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").HasChosen == true:
		_Buttons()

		await get_tree().create_timer(2.0).timeout


func _Buttons():
	var BowTimer = get_node("/root/AttackScene/User/PlayerPhase/Bow")
	
	#Set up Bow Timer
	BowTimer.time_to_press()
	shuffledButtonInputs = shuffleArray(originalButtonInputs)  # Shuffle the original buttonInputs array
	showButtonSprites()
	has_attacked = false

func showButtonSprites():
	
	var spritePositions = [
		Vector2(-400, 0),  # First column
		Vector2(-100, 0),  # Second column
		Vector2(100, 0),   # Third column
		Vector2(400, 0)    # Fourth column
	]
	var spriteIndices = shuffleArray(range(shuffledButtonInputs.size()))

	for i in range(originalButtonInputs.size()):
		var sprite = ButtonSprite.new()
		sprite.texture = load("res://Sprites/ArrowSprites/" + shuffledButtonInputs[spriteIndices[i]] + ".png")
		sprite.position = spritePositions[spriteIndices[i]]
		sprite.metadata = spriteIndices[i]  # Assign the index as metadata
		add_child(sprite)

# Defines if can input, then if can, then goes to _CheckInput
func _input(event):
	can_input(event)
	
func can_input(event):
	#If it is the Players Turn, These are the set of conditions.
	if get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING:
		if Input.is_action_pressed("Up_dir") == false and \
		   Input.is_action_pressed("Down_dir") == false and \
		   Input.is_action_pressed("Left_dir") == false and \
		   Input.is_action_pressed("Right_dir") == false:
			shouldCheckInput = false
		elif get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").HasChosen == true:
			shouldCheckInput = true #should be true
		
		if shouldCheckInput:
			_CheckInput(event)

func _CheckInput(event):
	
	if event is InputEventKey && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING:
		if Input.is_action_just_pressed(shuffledButtonInputs[currentInputIndex]):
			var spriteIndex = currentInputIndex

			# Find the sprite with the corresponding index
			var sprite = findButtonSpriteByIndex(spriteIndex)
			if sprite:
				sprite.queue_free()

			currentInputIndex += 1
			
			correctnessPercent += 10.0

			if currentInputIndex >= shuffledButtonInputs.size():
				currentInputIndex = 0
				shouldCheckInput = false
				has_attacked = true
				combat_phase_success.emit()

		else:
			combat_phase_fail.emit()

func findButtonSpriteByIndex(index: int) -> ButtonSprite:
	for child in get_children():
		if child is ButtonSprite and child.metadata == index:
			return child
	return null

func combatPhaseSuccess():
	# Code for successful completion of the combat phase
	print("Combat phase success!")
	get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").HasChosen = false
	if has_done_d_calc == false:
		DamageCalculation()
	if has_done_d_calc == true:
		kill_enemy()
	if has_done_damage == true:
		get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").GameState.ENEMY_TURN

func combatPhaseFail():
	# Code for failure in the combat phase
	# Hide all ButtonSprite children
	currentInputIndex = 0
	for child in get_children():
		if child is ButtonSprite:
			child.queue_free()
	
	get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").HasChosen = false
	shouldCheckInput = false
	if has_done_d_calc == false:
		DamageCalculation()
	if has_done_d_calc == true:
		kill_enemy()
	if has_done_damage == true:
		get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").GameState.ENEMY_TURN

func shuffleArray(array):
	var shuffledArray = array.duplicate()
	for i in range(shuffledArray.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = shuffledArray[i]
		shuffledArray[i] = shuffledArray[j]
		shuffledArray[j] = temp
	return shuffledArray


func DamageCalculation():
	if has_done_d_calc == false:
		has_done_damage = false
		#Define Base Damage (This should be equal to the damage of the weapon the player holds)
		BaseDamage = 100.0

		#Define the AimNode
		var AimNode = get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D")
		DamageMultiplier = AimNode.DamageMultiplier
		#Adjust The damage by the multiplier
		adjustedDamage = BaseDamage * DamageMultiplier
		finalDamage = adjustedDamage * (correctnessPercent / 100)
		damage = finalDamage
		print(finalDamage)
		has_done_d_calc = true
		
	
func kill_enemy():
	if has_done_d_calc == true && has_done_damage == false:
		var enemy = get_node("/root/AttackScene/Enemy")  # Adjust this path according to your node hierarchy
		enemy.take_damage(damage)  # Damage the enemy by its own health amount, effectively killing it
		has_done_d_calc = false
		has_done_damage = true
		#Reset Correctnesspercent back to 0 so combat values can be default for player's turn
		correctnessPercent = 0.0
		print(enemy.health)
		#has_attacked = false

			
#Aim Movement
func _process(delta):
	if shouldCheckInput == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING:
		const SPEED = 300.0
		#var AimBox = get_node("/root/AttackScene/Area2D")
		var AimBox = get_node("/root/AttackScene/User/PlayerPhase/Aiming")
		var x_direction_Left = Input.is_action_pressed("Left_dir")
		var x_direction_Right = Input.is_action_pressed("Right_dir")
		var y_direction_Up = Input.is_action_pressed("Up_dir")
		var y_direction_Down = Input.is_action_pressed("Down_dir")

		# Calculate the target position based on the current position and movement speed
		var targetPosition = AimBox.position

		# Left and Right Movement
		if x_direction_Left:
			targetPosition.x -= SPEED
		elif x_direction_Right:
			targetPosition.x += SPEED

		# Up and Down Movement
		if y_direction_Up:
			targetPosition.y -= SPEED
		elif y_direction_Down:
			targetPosition.y += SPEED

		AimBox.position = AimBox.position.move_toward(targetPosition, SPEED * delta)
