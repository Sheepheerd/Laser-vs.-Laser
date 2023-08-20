extends Control

var selected_option = 1
var num_options_vertical = 4
var num_options_horizontal = 2
var prev_vertical : float = 0
var prev_horizontal : float = 0
var has_selected = true

var player_1 = false
var player_2 = false

var lobby = false
@onready var _transition_rect = get_parent().get_parent().get_node("Transition/transition_controller")
@onready var p1_controller_animations = get_parent().get_parent().get_node("player_animation_sprites/p1_controller_animations")
@onready var p2_controller_animations = get_parent().get_parent().get_node("player_animation_sprites/p2_controller_animations")
@onready var button_animations = get_parent().get_parent().get_node("animation_controller/button_animations")
func _ready():
	#game_process_controller.current_game_process = game_process_controller.game_process.ui_map_selection
	p1_controller_animations.play("lobby_animations/p1_controller")
	p2_controller_animations.play("lobby_animations/p2_controller")
	#player_animation_sprites.play("lobby_animations/p2_controller")
	game_process_controller.game_lobby["player_1"] = false

	game_process_controller.game_lobby["player_2"] = false

	game_process_controller.game_lobby["full_lobby"] = false

	if Input.is_joy_button_pressed(0, 0) == true:
		has_selected = true
		
	button_animations.play("Pop_in")
func _process(delta):
	if game_process_controller.current_game_process == game_process_controller.game_process.ui_lobby:
		if Input.is_joy_button_pressed(0, 0) == false:
			has_selected = false
		
		
		if Input.is_joy_button_pressed(0, 1) == true:
			button_animations.play_backwards("Pop_in")
			_transition_rect.transition_to("res://UI/start_menu/ui_start.tscn")
		
		#PlayerLobby
		
		if Input.is_joy_button_pressed(0, 2):
			p1_controller_animations.stop()
			game_process_controller.game_lobby["player_1"] = true
			
		if Input.is_joy_button_pressed(1, 2):
			p2_controller_animations.stop()
			game_process_controller.game_lobby["player_2"] = true
			
		if game_process_controller.game_lobby["player_1"] == true && game_process_controller.game_lobby["player_2"] == true:
			game_process_controller.game_lobby["full_lobby"] = true

		if Input.is_joy_button_pressed(0, 0) && has_selected == false && game_process_controller.game_lobby["full_lobby"] == true: # Check for button press on player 1's controller
			match selected_option:
				1:
					battle()
			
			has_selected = true

func battle():
	game_process_controller.current_game_process = game_process_controller.game_process.ui_map_selection
	button_animations.play_backwards("Pop_in")
	_transition_rect.transition_to("res://UI/map_selection/ui_map_selection.tscn")



