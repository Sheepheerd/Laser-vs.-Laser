extends Control



var selected_option = 1
var num_options = 2

var prev_horizontal : float = 0.0
var prev_vertical : float = 0.0
var has_selected = false
var max_value = 10
var min_value = -15
var sfx_value
var music_value
@onready var _transition_rect = get_parent().get_parent().get_node("Transition/transition_controller")
@onready var button_pop_controller = get_parent().get_parent().get_node("animation_controller/Button_pop")
func _ready():
	if Input.is_joy_button_pressed(0, 0) == true:
		has_selected = true
	button_pop_controller.play("Pop_in")
func _process(delta):
	sfx_value = game_process_controller.sfx_value
	music_value = game_process_controller.music_value
	if game_process_controller.current_game_process == game_process_controller.game_process.sound_menu:
		
		if Input.is_joy_button_pressed(0, 0) == false:
			has_selected = false
		var vertical
		var horizontal
		horizontal = Input.get_joy_axis(0, 0) # Using player 1's controller analog input
		if horizontal > 0.5 and prev_horizontal <= 0.5:
			selected_option += 1
			selected_option = clamp(selected_option, 1, num_options)
			print(selected_option)

		if horizontal < -0.5 and prev_horizontal >= -0.5:
			selected_option -= 1
			selected_option = clamp(selected_option, 1, num_options)
			print(selected_option)

		prev_horizontal = horizontal
		
		
		if Input.is_joy_button_pressed(0, 0) == false:
			has_selected = false
			
		##AUDIO
		vertical = Input.get_joy_axis(0, 1) # Using player 1's controller analog input
		if selected_option == 2:
			if vertical > 0.5 && prev_vertical <= 0.5:
				game_process_controller.sfx_value -= 1
				#volume(1, sfx_value)
				game_process_controller.sfx_value = clamp(game_process_controller.sfx_value, min_value, max_value)
			elif vertical < -0.5 && prev_vertical >= -0.5:
				game_process_controller.sfx_value += 1
				#volume(1, sfx_value)
				game_process_controller.sfx_value = clamp(game_process_controller.sfx_value, min_value, max_value)

		if selected_option == 1:
			if vertical < -0.5 && prev_vertical >= -0.5:
				game_process_controller.music_value += 1
				#volume(1, music_value)
				game_process_controller.music_value = clamp(game_process_controller.music_value, min_value, max_value)
			elif vertical > 0.5 && prev_vertical <= 0.5:
				game_process_controller.music_value -= 1
				#volume(1, music_value)
				game_process_controller.music_value = clamp(game_process_controller.music_value, min_value, max_value)

		prev_vertical = vertical
		

		if Input.is_joy_button_pressed(0, 1) == true:
			game_process_controller.save_config()
			button_pop_controller.play_backwards("Pop_in")
			_transition_rect.transition_to("res://UI/options_menu/options_menu.tscn")
			game_process_controller.current_game_process = game_process_controller.game_process.options_menu
	
		if Input.is_joy_button_pressed(0, 0) && has_selected == false: # Check for button press on player 1's controller
			print("selected")
			match selected_option:
				1:
					music_up_down()
				2:
					back()
				3:
					sound_up_down()
	
			has_selected = true

func back():
	button_pop_controller.play_backwards("options_menu/Pop_in")
	_transition_rect.transition_to("res://UI/options_menu/options_menu.tscn")

	game_process_controller.current_game_process = game_process_controller.game_process.options_menu





func music_up_down():
	pass


func sound_up_down():
	pass
	
func master_up_down():
	pass

#func volume(bus_index, value):
#	AudioServer.set_bus_volume_db(bus_index, value)
