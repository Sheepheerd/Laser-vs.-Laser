extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$score_counter.text = str(game_process_controller.wins["player_1"])
	$score_counter2.text = str(game_process_controller.wins["player_2"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$score_counter.text = str(game_process_controller.wins["player_1"])
	$score_counter2.text = str(game_process_controller.wins["player_2"])
