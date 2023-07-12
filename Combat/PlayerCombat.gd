extends Node2D

class ButtonSprite extends Sprite2D:
	var metadata: int

var buttonInputs = ["Up_dir", "Down_dir", "Left_dir", "Right_dir", "Up_dir", "Down_dir", "Left_dir", "Right_dir"]
var currentInputIndex = 0
var shouldCheckInput = false

# Defining Signal
signal player_attack

func _on_ui_range_attack():
	var UI = get_node("/root/AttackScene/UI")
	if UI.current_game_state == UI.GameState.PLAYER_ATTACKING:
		_Buttons()
		shouldCheckInput = true

func _Buttons():
	buttonInputs = shuffleArray(buttonInputs)  # Shuffle the buttonInputs array
	showButtonSprites()

func showButtonSprites():
	var spritePositions = [
		Vector2(0, 400),
		Vector2(0, 250),  # First column
		Vector2(0, 100),   # Second column
		Vector2(0, -100),    # Third column
		Vector2(0, -250),    # Fourth column
		Vector2(0, -400),
		Vector2(0, -550),
		Vector2(0, -700)
	]
	var shuffledIndices = shuffleArray(range(buttonInputs.size()))
	
	for i in range(buttonInputs.size()):
		var sprite = ButtonSprite.new()
		sprite.texture = load("res://Sprites/Test_Tile_Sprite_Holders/White_Square.png")
		sprite.position = spritePositions[shuffledIndices[i]]
		sprite.metadata = shuffledIndices[i]  # Assign the index as metadata
		add_child(sprite)

func _input(event):
	if shouldCheckInput:
		_CheckInput(event)

func _CheckInput(event):
	if event is InputEventKey:
		if event.is_action_just_pressed(buttonInputs[currentInputIndex]):
			var spriteIndex = currentInputIndex

			# Find the sprite with the corresponding index
			var sprite = findButtonSpriteByIndex(spriteIndex)
			if sprite:
				sprite.hide()

			currentInputIndex += 1

			if currentInputIndex >= buttonInputs.size():
				combatPhaseSuccess()
				currentInputIndex = 0
				shouldCheckInput = false
				kill_enemy()
				#buttonInputs = shuffleArray(buttonInputs)  # Reset the buttonInputs array

				
			elif not event.is_action_just_pressed(buttonInputs[currentInputIndex]):
				combatPhaseFail()
				get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").GameState.ENEMY_TURN
				shouldCheckInput = false  # Disable input checking

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
	print("Bruh")

func shuffleArray(array):
	var shuffledArray = []
	var size = array.size()

	for i in range(size):
		shuffledArray.append(array[i])
	
	for i in range(size - 1):
		var randomIndex = randi() % (size - i)
		var temp = shuffledArray[i]
		shuffledArray[i] = shuffledArray[i + randomIndex]
		shuffledArray[i + randomIndex] = temp
	
	return shuffledArray
	
#Place Holder For Attack
func kill_enemy():
	var enemy = get_node("/root/AttackScene/Enemy")  # Adjust this path according to your node hierarchy
	enemy.take_damage(50)  # Damage the enemy by its own health amount, effectively killing it
