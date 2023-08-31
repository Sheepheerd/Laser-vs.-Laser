extends Node2D

var camera1 : Camera2D
var camera2 : Camera2D
var original_camera1_position : Vector2
var original_camera2_position : Vector2
@export var shake_amplitude : float = 5.0
var shake_duration : float = 1.0
var shake_timer

func _ready():
	game_process_controller.shake_timer = 0.0
	camera1 = get_parent().get_parent().get_parent().get_parent().get_node("player_camera_1")

	original_camera1_position = camera1.position


func _process(delta: float):
	if game_process_controller.current_game_process == game_process_controller.game_process.game_fight:
		if game_process_controller.shake_timer > 0.0:
			game_process_controller.shake_timer -= delta
			var offset = Vector2(randf_range(-shake_amplitude, shake_amplitude), randf_range(-shake_amplitude, shake_amplitude))
			camera1.position = original_camera1_position + offset
		elif shake_timer == 0.0:
			camera1.position = original_camera1_position

func start_camera_shake():
	game_process_controller.shake_timer = shake_duration

func randf_range(min: float, max: float) -> float:
	return randf() * (max - min) + min

func shoot_bullet_and_shake(player_index: int):
	start_camera_shake()
