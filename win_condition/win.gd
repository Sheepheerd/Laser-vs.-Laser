extends Node2D

var required_wins
var defaults_restored
@onready var win_animation = get_parent().get_parent().get_parent().get_node("win_shader/animation_controller/AnimationPlayer")
func _ready():
	defaults_restored = false
	#game_process_controller.required_wins = 3

func _process(delta):
	if game_process_controller.current_game_process == game_process_controller.game_process.game_win:
		if game_process_controller.wins["player_1"] == game_process_controller.required_wins:
			win_animation.play("win_animations/win_glitch")
			#get_tree().paused = true
			get_parent().get_parent().get_parent().get_node("win_menu_back_buffer/CanvasLayer").show()
			restore_default_stats()
			print("player 1 wins")
			if defaults_restored == true:
				print("restored")
				#get_tree().change_scene_to_file("res://UI/start_menu/ui_start.tscn")
			else:
				return
		elif game_process_controller.wins["player_2"] == game_process_controller.required_wins:
			win_animation.play("win_animations/win_glitch")
			#get_tree().paused = true
			restore_default_stats()
			print("player 2 wins")
			if defaults_restored == true:
				print("restored")
				#get_tree().change_scene_to_file("res://UI/start_menu/ui_start.tscn")
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
