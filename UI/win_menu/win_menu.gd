extends Control


var selected_option = 1
var num_options = 2

var prev_vertical : float = 0
var has_selected = false

var is_paused = false

var can_press = true
var defaults_restored = false
@onready var animation_controller = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("animation_controller/Game_pop")
@onready var _transition_rect = get_parent().get_parent().get_node("black_click_transition/scene_black_click_transition")
@onready var effects = get_parent().get_parent().get_node("Transition")
func _ready():
	animation_controller.play("game_animations/Pop_in")
	config_transition()
	if Input.is_joy_button_pressed(0, 0) == true:
		has_selected = true
	
	$Rematch.hide()
	$Quite.hide()
	effects.hide()
		
func _process(delta):

	if Input.is_joy_button_pressed(0, 0) == false:
			has_selected = false
	
	#if game_process_controller.current_game_process == game_process_controller.game_process.pause_menu:
	if game_process_controller.current_game_process == game_process_controller.game_process.game_win:
		_win_menu()
		
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
					_on_rematch_pressed()
				
				2:
					_on_quit_to_main_menu_pressed()
		
			has_selected = true


func _win_menu():
	
	$Rematch.show()
	$Quite.show()
	effects.show()
	

func _on_rematch_pressed():
	Engine.time_scale = 1
	$Rematch.hide()
	$Quite.hide()
	animation_controller.play_backwards("game_animations/Pop_in")
	restore_default_stats()
	if defaults_restored == true:
		_transition_rect.transition_to("res://UI/map_selection/ui_map_selection.tscn")
		game_process_controller.current_game_process = game_process_controller.game_process.ui_map_selection
	else:
		return
	
func _on_options_pressed():
	pass
	
func _on_quit_to_main_menu_pressed():
	Engine.time_scale = 1
	animation_controller.play_backwards("game_animations/Pop_in")
	restore_default_stats()
	if defaults_restored == true:
		#get_parent().get_parent().get_node("animation_controller/Button_pop").play_backwards("start_menu_animations/Pop_in")
		_transition_rect.transition_to("res://UI/start_menu/ui_start.tscn")
		game_process_controller.current_game_process = game_process_controller.game_process.start_menu
	else:
		return



func restore_default_stats():
	for key in gun_tags.player_1_stats_defaults.keys():
		gun_tags.player_1_stats[key] = gun_tags.player_1_stats_defaults[key]
	for key in gun_tags.player_2_stats_defaults.keys():
		gun_tags.player_2_stats[key] = gun_tags.player_2_stats_defaults[key]
	game_process_controller.wins["player_1"] = 0
	game_process_controller.wins["player_2"] = 0
	defaults_restored = true
	
func config_transition():
	_transition_rect.get_node("AnimationPlayer").stop()
