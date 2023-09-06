extends Control



var selected_option = 1
var num_options = 3

var prev_vertical : float = 0.0
var has_selected = false
@onready var _transition_rect = get_parent().get_parent().get_node("Transition/transition_controller")
@onready var button_pop_controller = get_parent().get_parent().get_node("animation_controller/Button_pop")
func _ready():
	if Input.is_joy_button_pressed(0, 0) == true:
		has_selected = true
		
func _process(delta):

	if game_process_controller.current_game_process == game_process_controller.game_process.options_menu:
		
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
		
		if Input.is_joy_button_pressed(0, 1) == true:
				button_pop_controller.play_backwards("options_menu/Pop_in")
				_transition_rect.transition_to("res://UI/start_menu/ui_start.tscn")
		
	
		if Input.is_joy_button_pressed(0, 0) && has_selected == false: # Check for button press on player 1's controller
			print("selected")
			match selected_option:
				1:
					fullscreen()
				2:
					sound()
				3:
					back()
	
			has_selected = true

func back():
	button_pop_controller.play_backwards("options_menu/Pop_in")
	_transition_rect.transition_to("res://UI/start_menu/ui_start.tscn")

	game_process_controller.current_game_process = game_process_controller.game_process.start_menu

func fullscreen():
	var config = ConfigFile.new()
	
	if DisplayServer.window_get_mode():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		config.set_value("Settings", "Fullscreen", false)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		config.set_value("Settings", "Fullscreen", true)
	
	config.save("res://settings.cfg")

func sound():
	pass
