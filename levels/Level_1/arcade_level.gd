extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if game_process_controller.not_playing_game_music == true:
		game_music.play_music()
		game_process_controller.not_playing_game_music = false

