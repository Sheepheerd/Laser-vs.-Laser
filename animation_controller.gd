extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _process(delta):
	var horizontal = Input.get_action_strength("right_dir") - Input.get_action_strength("left_dir")
	var vertical = Input.get_action_strength("down_dir") - Input.get_action_strength("up_dir")

	#if horizontal != 0:
		#animated_sprite.play("idle")

