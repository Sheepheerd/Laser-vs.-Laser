extends Node2D

class ButtonSprite extends Sprite2D:
	var metadata: int

var originalButtonInputs = ["Up_dir", "Down_dir", "Up_dir", "Down_dir"]
var shuffledButtonInputs = []  # Holds the shuffled button inputs for each combat phase
var currentInputIndex = 0
var shouldCheckInput = false

# Defining Signal
signal player_attack

	
func _on_ui_range_attack():
	var UI = get_node("/root/AttackScene/UI")
	if UI.current_game_state == UI.GameState.PLAYER_ATTACKING:
		_Buttons()
		await get_tree().create_timer(2.0).timeout
		

func _Buttons():
	shuffledButtonInputs = shuffleArray(originalButtonInputs)  # Shuffle the original buttonInputs array
	showButtonSprites()

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

func _CheckInput(event):
	if event is InputEventKey:
		if event.is_action_pressed(shuffledButtonInputs[currentInputIndex]):
			var spriteIndex = currentInputIndex

			# Find the sprite with the corresponding index
			var sprite = findButtonSpriteByIndex(spriteIndex)
			if sprite:
				sprite.queue_free()

			currentInputIndex += 1

			if currentInputIndex >= shuffledButtonInputs.size():
				combatPhaseSuccess()
				currentInputIndex = 0
				shouldCheckInput = false
				kill_enemy()

		else:
			combatPhaseFail()

func findButtonSpriteByIndex(index: int) -> ButtonSprite:
	for child in get_children():
		if child is ButtonSprite and child.metadata == index:
			return child
	return null

func combatPhaseSuccess():
	# Code for successful completion of the combat phase
	print("Combat phase success!")
	get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").GameState.ENEMY_TURN

func combatPhaseFail():
	# Code for failure in the combat phase
	# Hide all ButtonSprite children
	for child in get_children():
		if child is ButtonSprite:
			child.queue_free()
			
	shouldCheckInput = false
	get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").GameState.ENEMY_TURN

func shuffleArray(array):
	var shuffledArray = array.duplicate()
	for i in range(shuffledArray.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = shuffledArray[i]
		shuffledArray[i] = shuffledArray[j]
		shuffledArray[j] = temp
	return shuffledArray

# Placeholder For Attack
func kill_enemy():
	var enemy = get_node("/root/AttackScene/Enemy")  # Adjust this path according to your node hierarchy
	enemy.take_damage(50)  # Damage the enemy by its own health amount, effectively killing it

func can_input(event):
	if get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING:
		if Input.is_action_pressed("Up_dir") == false and \
		   Input.is_action_pressed("Down_dir") == false and \
		   Input.is_action_pressed("Left_dir") == false and \
		   Input.is_action_pressed("Right_dir") == false:
			shouldCheckInput = false
		else:
			shouldCheckInput = true #should be true
		
		if shouldCheckInput:
			_CheckInput(event)
			
#Aim


func _process(delta):
	if shouldCheckInput == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING:
		const SPEED = 300.0
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

		if Input.is_action_pressed("Accept"):
			#get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").Enter()
			pass
