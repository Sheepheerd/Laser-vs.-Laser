extends Node2D

#Set Up Turns
enum GameState {PLAYER_TURN, PLAYER_ATTACKING, ENEMY_TURN, ENEMY_ATTACKING}

var current_game_state = GameState.PLAYER_TURN

#Set Up Player
@onready var player = get_node("/root/AttackScene/User/Player")

#Set Up Selection
var current_selection = 1
var selection_positions = []
var attack_selection_positions = []


#Set Up The UI Buttons
@onready var AttackButton = get_node("/root/AttackScene/UI/AttackButton")
@onready var ItemButton = get_node("/root/AttackScene/UI/ItemButton")
@onready var RunButton = get_node("/root/AttackScene/UI/RunButton")
@onready var RangeButton = get_node("/root/AttackScene/UI/RangeButton")
@onready var Cursor = get_node("/root/AttackScene/UI/Cursor")
@onready var DisplayTile = get_node("/root/AttackScene/UI/Display")
@onready var AimBoxSprite = get_node("/root/AttackScene/User/PlayerPhase/Aiming/AimBox")

#Pre-setup for UI Selection
func _ready():
	selection_positions = [
		AttackButton.global_position + Vector2(150, -45),
		ItemButton.global_position + Vector2(150, -45),
		RunButton.global_position + Vector2(150, -45)
	]
	attack_selection_positions = [
		#Add more here for more options
		RangeButton.global_position + Vector2(150, -45)
	]
	Cursor.global_position = selection_positions[current_selection - 1]
	
	RangeButton.hide()


#Set Up Turns
func _process(delta):
	if current_game_state == GameState.PLAYER_TURN:
		if AttackButton.is_visible():
			process_normal_selection(delta)
		else:
			process_attack_selection(delta)
			
	elif current_game_state == GameState.PLAYER_ATTACKING:
		hide_all_pre_attack_sprites() # Hide all buttons before attacking
		playerPosition = Vector2(0, 1)
		
	#Checks If Enemey Health Is not = 0 Before Starting Enemy Turn
	elif current_game_state == GameState.ENEMY_TURN && get_node("/root/AttackScene/Enemy").health != 0:
		current_game_state = GameState.ENEMY_ATTACKING
		player.get_node("/root/AttackScene/User/Player/MainSprite").show()
		get_node("/root/AttackScene/Enemy").attack_player()
	
	elif current_game_state == GameState.ENEMY_ATTACKING:
		# Player movement during enemy's turn
		PlayerMovement()
		
		

		
#Set Up Selection for the Curson on The Selection Screen
func process_normal_selection(_delta):

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
func process_attack_selection(_delta):
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
				_on_range_pressed()



#If Attack is Pressed
func _on_attack_button_pressed():
	AttackButton.hide()
	ItemButton.hide()
	RunButton.hide()
	RangeButton.show()
	
	DisplayTile.hide()
	
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
	RangeButton.hide()
	player.position = Vector2(-2, 120)
	DisplayTile.hide()
	
	current_selection = 1
	Cursor.global_position = selection_positions[current_selection - 1]

#When Range Button Is Pressed
#Define Signal
signal range_attack
func _on_range_pressed():
	# Perform range attack
	AimBoxSprite.show()
	current_game_state = GameState.PLAYER_ATTACKING
	emit_signal("range_attack")
	print("Range attack")
	#current_game_state = GameState.ENEMY_TURN  # Switch to enemy turn after attack
	
#On Enemy Turn, Hide All Buttons
func hide_all_pre_attack_sprites():
	AttackButton.hide()
	ItemButton.hide()
	RunButton.hide()
	RangeButton.hide()
	Cursor.hide()
	player.get_node("/root/AttackScene/User/Player/MainSprite").hide()
	
	
#Player Movement For Enemy Combat
# Set up the tile map
const TILE_SIZE = 128  # Adjust this value based on your tile size

# Define the map boundaries
const MAP_WIDTH = 3
const MAP_HEIGHT = 4

# Set up player position and tilemap
var playerPosition = Vector2(0, 1)

# Convert tile position to world position
func tile_to_world(tilePos):
	return tilePos * TILE_SIZE
	

# Check if a position is within the map bounds
func is_valid_position(position):
	return position.x >= -2 && position.x < MAP_WIDTH && position.y >= -1 && position.y < MAP_HEIGHT
	
func PlayerMovement():
	DisplayTile.show()
	player.set_position(tile_to_world(playerPosition))
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
		var newPosition = playerPosition + movement
		if is_valid_position(newPosition):
			playerPosition = newPosition

	
	
