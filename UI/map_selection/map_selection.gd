extends Control


var player_1 = false
var player_2 = false

var selected_option = 1
var num_options = 3

var prev_vertical : float = 0.0
var has_selected = false

func _ready():
	
	if Input.is_joy_button_pressed(0, 0) == true:
		has_selected = true
		
func _process(delta):
	if 	game_process_controller.current_game_process == game_process_controller.game_process.ui_map_selection:
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
					_on_map_1_pressed()
				2:
					_on_map_2_pressed()
				3:
					_on_map_3_pressed()
					
			has_selected = true

		if Input.is_joy_button_pressed(0, 2):
			player_1 = true
		

func _on_map_1_pressed():
	if player_1 == true: #&& player_2 == true:
		#game_process_controller.current_game_process = game_process_controller.game_process.cards_selection
		game_process_controller.current_game_process = game_process_controller.game_process.game_fight
		get_tree().change_scene_to_file("res://overworld.tscn")

func _on_map_2_pressed():
	pass # Replace with function body.


func _on_map_3_pressed():
	pass # Replace with function body.
