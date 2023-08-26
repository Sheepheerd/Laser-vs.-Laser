extends Node2D
var can_animate = false

func _ready():
	$Game_pop.play("game_animations/Pop_in")
	await get_tree().create_timer(2).timeout
		
