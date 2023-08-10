extends Node2D

var required_wins
var defaults_restored
func _ready():
	defaults_restored = false
	game_process_controller.required_wins = 3

func _process(delta):
	if game_process_controller.current_game_process == game_process_controller.game_process.game_win:
		if game_process_controller.wins["player_1"] == game_process_controller.required_wins:
			restore_default_stats()
			print("player 1 wins")
			if defaults_restored == true:
				get_tree().change_scene_to_file("res://UI/ui_start.tscn")
			else:
				return
		elif game_process_controller.wins["player_2"] == game_process_controller.required_wins:
			restore_default_stats()
			print("player 2 wins")
			if defaults_restored == true:
				get_tree().change_scene_to_file("res://UI/ui_start.tscn")
			else:
				return

func restore_default_stats():
	gun_tags.player_1_stats = gun_tags.player_1_stats_defaults
	gun_tags.player_2_stats = gun_tags.player_2_stats_defaults
	defaults_restored = true
