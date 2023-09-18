extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$music.text = str(game_process_controller.music_value + 5)
	$sfx.text = str(game_process_controller.sfx_value + 5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$music.text = str(game_process_controller.music_value + 5)
	$sfx.text = str(game_process_controller.sfx_value + 5)
