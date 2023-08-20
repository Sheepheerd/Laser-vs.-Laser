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
@onready var button_animation_controller = get_parent().get_parent().get_node("animation_controller/Button_pop")
func _ready():
	button_animation_controller.play("map_selection/Pop_in")
	#game_process_controller.current_game_process = game_process_controller.game_process.ui_map_selection
	game_process_controller.game_lobby["player_1"] = true

	game_process_controller.game_lobby["player_2"] = true

	game_process_controller.game_lobby["full_lobby"] = true
	
	if Input.is_joy_button_pressed(0, 0) == true:
		has_selected = true
		
func _process(delta):
	if game_process_controller.current_game_process == game_process_controller.game_process.ui_map_selection:
		if Input.is_joy_button_pressed(0, 0) == false:
			has_selected = false
		
		var vertical
		var horizontal
		horizontal = Input.get_joy_axis(0, 0)
		vertical = Input.get_joy_axis(0, 1) # Using player 1's controller analog input

		if vertical > 0.5 and prev_vertical <= 0.5:
			selected_option += 1
			selected_option = clamp(selected_option, 1, num_options_vertical)
			print(selected_option)

		if vertical < -0.5 and prev_vertical >= -0.5:
			selected_option -= 1
			selected_option = clamp(selected_option, 1, num_options_vertical)
			print(selected_option)
		
		if horizontal > 0.5 and prev_horizontal <= 0.5:
			selected_option += 2
			selected_option = clamp(selected_option, 1, num_options_vertical)
			print(selected_option)

		if horizontal < -0.5 and prev_horizontal >= -0.5:
			selected_option -= 2
			selected_option = clamp(selected_option, 1, num_options_vertical)
			print(selected_option)

		prev_vertical = vertical
		prev_horizontal = horizontal
		
		if Input.is_joy_button_pressed(0, 1) == true:
			game_process_controller.current_game_process = game_process_controller.game_process.ui_lobby
			button_animation_controller.play_backwards("map_selection/Pop_in")
			_transition_rect.transition_to("res://UI/lobby/game_lobby.tscn")
		
			

		if Input.is_joy_button_pressed(0, 0) && has_selected == false && game_process_controller.game_lobby["full_lobby"] == true: # Check for button press on player 1's controller
			match selected_option:
				1:
					map_1()
				2:
					map_2()
					
				3:
					map_3()
				4:
					map_4()
			
			has_selected = true

func map_1():
	game_process_controller.current_game_process = game_process_controller.game_process.game_fight
	button_animation_controller.play_backwards("map_selection/Pop_in")
	_transition_rect.transition_to("res://overworld.tscn")



func map_2():
	pass


func map_3():
	pass
	
func map_4():
	pass

