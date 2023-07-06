extends Node2D

#Set Up Turns
enum GameState {PLAYER_TURN, PLAYER_ATTACKING, ENEMY_TURN, ENEMY_ATTACKING}

var current_game_state = GameState.PLAYER_TURN

#Set Up Player
@onready var player = get_node("/root/AttackScene/Player")

#Set Up Selection
var current_selection = 1
var selection_positions = []
var attack_selection_positions = []

#Set Up The UI Buttons
@onready var AttackButton = get_node("/root/AttackScene/UI/AttackButton")
@onready var ItemButton = get_node("/root/AttackScene/UI/ItemButton")
@onready var RunButton = get_node("/root/AttackScene/UI/RunButton")
@onready var MeleeButton = get_node("/root/AttackScene/UI/MeleeButton")
@onready var RangeButton = get_node("/root/AttackScene/UI/RangeButton")
@onready var Cursor = get_node("/root/AttackScene/UI/Cursor")

#Pre-setup for UI Selection
func _ready():
	selection_positions = [
		AttackButton.global_position + Vector2(150, -45),
		ItemButton.global_position + Vector2(150, -45),
		RunButton.global_position + Vector2(150, -45)
	]
	attack_selection_positions = [
		MeleeButton.global_position + Vector2(150, -45),
		RangeButton.global_position + Vector2(150, -45)
	]
	Cursor.global_position = selection_positions[current_selection - 1]
	MeleeButton.hide()
	RangeButton.hide()
	
	#Set up Tilemap Position


#Set Up Turns
func _process(_delta):
	if current_game_state == GameState.PLAYER_TURN:
		if AttackButton.is_visible():
			process_normal_selection(_delta)
		else:
			process_attack_selection(_delta)
	#Checks If Enemey Health Is not = 0 Before Starting Enemy Turn
	elif current_game_state == GameState.ENEMY_TURN && get_node("/root/AttackScene/Enemy").health != 0:
		current_game_state = GameState.ENEMY_ATTACKING
		get_node("/root/AttackScene/Enemy").attack_player()
	
	elif current_game_state == GameState.ENEMY_ATTACKING:
		# Player movement during enemy's turn
		var movement = Vector2.ZERO
		if Input.is_action_just_pressed("Right_dir"):
			movement.x += 1
		elif Input.is_action_just_pressed("Left_dir"):
			movement.x -= 1
		elif Input.is_action_just_pressed("Down_dir"):
			movement.y += 1
		elif Input.is_action_just_pressed("Up_dir"):
			movement.y -= 1
		
		if movement != Vector2.ZERO:
			# Update the player's position
			var newPosition = playerPosition + movement
			if is_valid_position(newPosition):
				playerPosition = newPosition
			
		# Update the player's position in the game world
		player.set_position(tile_to_world(playerPosition))

		
#Set Up Selection for the Curson on The Selection Screen
func process_normal_selection(delta):
	if Input.is_action_just_pressed("Right_dir"):
		current_selection = (current_selection % 3) + 1
		Cursor.global_position = selection_positions[current_selection - 1]
	elif Input.is_action_just_pressed("Left_dir"):
		current_selection = ((current_selection - 2) % 3) + 1
		Cursor.global_position = selection_positions[current_selection - 1]

	if Input.is_action_just_pressed("ui_accept"):
		match current_selection:
			1: 
				_on_attack_button_pressed()
			2:
				_on_item_button_pressed()
			3:
				_on_run_button_pressed()


#Set Up Selection for the Curson on The Attack Scene
func process_attack_selection(delta):
	if Input.is_action_just_pressed("Right_dir"):
		current_selection = (current_selection % 2) + 1
		Cursor.global_position = attack_selection_positions[current_selection - 1]
	elif Input.is_action_just_pressed("Left_dir"):
		current_selection = ((current_selection - 2) % 2) + 1
		Cursor.global_position = attack_selection_positions[current_selection - 1]
	elif Input.is_action_just_pressed("Back"):
		_on_back_pressed()

	if Input.is_action_just_pressed("ui_accept"):
		match current_selection:
			1: 
				_on_melee_pressed()
			2: 
				_on_range_pressed()


#If Attack is Pressed
func _on_attack_button_pressed():
	AttackButton.hide()
	ItemButton.hide()
	RunButton.hide()
	MeleeButton.show()
	RangeButton.show()
	current_selection = 1
	Cursor.global_position = attack_selection_positions[current_selection - 1]

#If Item Is Pressed
func _on_item_button_pressed():
	# Open the bag
	print("Open the bag")

#If Run Is Pressed
func _on_run_button_pressed():
	# Transition back to the original scene
	get_tree().change_scene_to_file(BattleData.previous_scene_path)

#If Back Is pressed, go from Attack Menu to Selection Menu
func _on_back_pressed():
	AttackButton.show()
	ItemButton.show()
	RunButton.show()
	Cursor.show()
	MeleeButton.hide()
	RangeButton.hide()
	current_selection = 1
	Cursor.global_position = selection_positions[current_selection - 1]

#When Melee Button Is Pressed
func _on_melee_pressed():
	# Perform melee attack
	current_game_state = GameState.PLAYER_ATTACKING
	hide_all_buttons()  # Hide all buttons after attacking
	player.melee()
	print("Melee attack")
	kill_enemy()
	#current_game_state = GameState.ENEMY_TURN  # Switch to enemy turn after attack
	
#When Range Button Is Pressed
func _on_range_pressed():
	# Perform range attack
	hide_all_buttons()  # Hide all buttons after attacking
	print("Range attack")
	kill_enemy()
	current_game_state = GameState.ENEMY_TURN  # Switch to enemy turn after attack

#Place Holder For Attack
func kill_enemy():
	var enemy = get_node("/root/AttackScene/Enemy")  # Adjust this path according to your node hierarchy
	enemy.take_damage(50)  # Damage the enemy by its own health amount, effectively killing it
	
	
#On Enemy Turn, Hide All Buttons
func hide_all_buttons():
	AttackButton.hide()
	ItemButton.hide()
	RunButton.hide()
	MeleeButton.hide()
	RangeButton.hide()
	Cursor.hide()
	
	
	
#Player Movement For Enemy Combat
# Set up the tile map
const TILE_SIZE = 128  # Adjust this value based on your tile size

# Define the map boundaries
const MAP_WIDTH = 4
const MAP_HEIGHT = 4

# Set up player position and tilemap
var playerPosition = Vector2(0, 1)
@onready var tileMap = get_node("/root/AttackScene/Player/TileMap")

# Convert tile position to world position
func tile_to_world(tilePos):
	return tilePos * TILE_SIZE

# Check if a position is within the map bounds
func is_valid_position(position):
	return position.x >= -3 && position.x < MAP_WIDTH && position.y >= -1 && position.y < MAP_HEIGHT
