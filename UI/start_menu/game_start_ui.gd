extends Control

var selected_option = 1
var num_options = 3

var prev_vertical : float = 0
var has_selected = false
func _ready():
	game_process_controller.current_game_process = game_process_controller.game_process.start_menu
	var config = ConfigFile.new()
	
	if config.load("res://settings.cfg") == OK:
		var fullscreen = config.get_value("Settings", "Fullscreen", false)
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	if Input.is_joy_button_pressed(0, 0) == true:
		has_selected = true
		
func _process(delta):
	if 	game_process_controller.current_game_process == game_process_controller.game_process.start_menu:
		if Input.is_joy_button_pressed(0, 0) == false:
			has_selected = false
		
		var vertical
		vertical = Input.get_joy_axis(0, 1) # Using player 1's controller analog input

		if vertical > 0.5 and prev_vertical <= 0.5:
			selected_option += 1
			selected_option = clamp(selected_option, 1, num_options)
			print(selected_option)

		if vertical < -0.5 and prev_vertical >= -0.5:
			selected_option -= 1
			selected_option = clamp(selected_option, 1, num_options)
			print(selected_option)

		prev_vertical = vertical
		



		if Input.is_joy_button_pressed(0, 0) && !has_selected: # Check for button press on player 1's controller
			match selected_option:
				1:
					_on_play_pressed()
				2:
					_on_options_pressed()
					
				3:
					_on_quit_pressed()
		
			has_selected = true

func _on_play_pressed():
	get_tree().change_scene_to_file("res://UI/lobby/game_lobby.tscn")
	game_process_controller.current_game_process = game_process_controller.game_process.ui_map_selection



func _on_options_pressed():
	game_process_controller.current_game_process = game_process_controller.game_process.options_menu
	get_tree().change_scene_to_file("res://UI/options_menu/options_menu.tscn")



func _on_quit_pressed():
	get_tree().quit()
