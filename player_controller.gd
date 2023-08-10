extends Node2D

const playerscene: = preload("res://player_scripts/player.tscn")
var player_1 = false
var player_2 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if game_process_controller.current_game_process == game_process_controller.game_process.game_fight:
		var player_1_instance = playerscene.instantiate()
		if map_selection.player_1 == true:
			player_1_instance.player_index = 0
			add_child(player_1_instance)

		var player_2_instance = player_1_instance.duplicate()  # Duplicate the player 1 instance
		if player_2 == false:
			player_2_instance.global_position = Vector2(100, 0)
			player_2_instance.player_index = 1
			add_child(player_2_instance)

