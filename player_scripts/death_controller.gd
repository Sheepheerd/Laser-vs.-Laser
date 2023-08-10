extends Node2D

var gun_controller
var player_index
var dead_player
var alive_player
var dead_player_declared = false
func _ready():
	dead_player_declared = false
	player_index = get_parent().player_index
	
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
		dead_player = "player_1"
		alive_player = "player_2"
		#dead_player_declared = true

	elif player_index == 1:
		gun_controller = gun_tags.player_2_stats
		dead_player = "player_2"
		alive_player = "player_1"
		#dead_player_declared = true
	game_process_controller.player_death[dead_player] = false
	game_process_controller.player_death[alive_player] = false
func _process(delta):
	# Fix This....this permanently changes the scene because the health is never reset
	if gun_controller["health"] <= 0: #&& dead_player_declared:
		dead_player_declared = false
		game_process_controller.player_death[dead_player] = true  # Update the dictionary
		gun_controller["health"] = 100
		print("change")
		
		game_process_controller.wins[alive_player] += 1
		
		if game_process_controller.wins[alive_player] == game_process_controller.required_wins:
			game_process_controller.current_game_process = game_process_controller.game_process.game_win
		
		else:
			game_process_controller.current_game_process = game_process_controller.game_process.cards_selection_loser
			get_tree().change_scene_to_file("res://card_mechanic/card_selection_scenes/cards_selection_loser.tscn")
