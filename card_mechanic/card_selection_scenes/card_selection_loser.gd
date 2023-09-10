extends Control


var card_scene_paths
var shuffled_card_scene_paths = []

var display_cards := []

var selected_option = 1
var num_options = 3

var prev_horizontal : float = 0
var has_selected = false
var player_index
@onready var _transition_rect = get_parent().get_parent().get_node("black_click_transition/scene_black_click_transition")
@onready var card_effects = get_parent().get_parent().get_node("ready_transition/AnimationPlayer")
func _ready():
	card_scene_paths = game_process_controller.card_scene_paths
	if 	game_process_controller.current_game_process == game_process_controller.game_process.cards_selection_loser:
		
		card_effects.play("cards_ready_pulse/cards_pulse")
		if game_process_controller.player_death["player_1"] == true && game_process_controller.player_death["player_2"] == false:
			player_index = 0
		#if player two dies
		elif game_process_controller.player_death["player_1"] == false && game_process_controller.player_death["player_2"] == true:
			player_index = 1
		shuffle_cards()
		display_random_cards()
#	if 	game_process_controller.current_game_process == game_process_controller.game_process.cards_selection_winner:
#		if game_process_controller.player_death["player_1"] == true && game_process_controller.player_death["player_2"] == false:
#			player_index = 1
#		#if player two dies
#		elif game_process_controller.player_death["player_1"] == false && game_process_controller.player_death["player_2"] == true:
#			player_index = 0
#	if Input.is_joy_button_pressed(dead_player, 0) == true:
#		has_selected = true

var good_player
func _process(event):

		if player_index == 0:
			good_player = 0
		else:
			good_player = 1
		

		if Input.is_joy_button_pressed(player_index, 0) == false:
			has_selected = false
		if Input.is_joy_button_pressed(player_index, 0):
			handle_selection()

		var horizontal
		horizontal = Input.get_joy_axis(good_player, 0)# Using player 1's controller analog input

		if horizontal > 0.5 and prev_horizontal <= 0.5:
			selected_option += 1
			selected_option = clamp(selected_option, 1, num_options)
			print(selected_option)

		if horizontal < -0.5 and prev_horizontal >= -0.5:
			selected_option -= 1
			selected_option = clamp(selected_option, 1, num_options)
			print(selected_option)

		prev_horizontal = horizontal
		
		if selected_option == 1:
			get_child(0).grab_focus()
		elif selected_option == 2:
			get_child(1).grab_focus()
		elif selected_option == 3:
			get_child(2).grab_focus()

func shuffle_cards():
	shuffled_card_scene_paths = shuffle_array(card_scene_paths)

func display_random_cards():
	var card_positions = [
		Vector2(150, 200),  # First column
		Vector2(760, 200),
		Vector2(1370, 200)
	]

	for i in range(3):  # Display the first 3 shuffled cards
		var card = load(shuffled_card_scene_paths[i]).instantiate()
		card.position = card_positions[i]
		add_child(card)
		display_cards.append(card)

func shuffle_array(array):
	var shuffled_array = array.duplicate()
	for i in range(shuffled_array.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = shuffled_array[i]
		shuffled_array[i] = shuffled_array[j]
		shuffled_array[j] = temp
	return shuffled_array

func handle_selection():
#	if has_selected:
#		return
	
	if has_selected == false:
		print("selected")
		match selected_option:
			1:
				display_cards[selected_option - 1].action()
			2:
				display_cards[selected_option - 1].action()
			3:
				display_cards[selected_option - 1].action()
		
		has_selected = true
	if game_process_controller.current_game_process == game_process_controller.game_process.cards_selection_loser:
		game_process_controller.current_game_process = game_process_controller.game_process.game_fight
		#Fix this for Different Levels
		_transition_rect.transition_to("res://levels/Level_1/arcade_level.tscn")

