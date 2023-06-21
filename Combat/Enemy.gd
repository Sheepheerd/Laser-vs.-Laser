extends Node2D

var previous_scene_path = "res://CharacterTest.tscn"  # Replace with your actual scene path

var health = 100

@onready var sprite = get_node("/root/AttackScene/Enemy/Sprite2D")

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
		await get_tree().create_timer(3).timeout
		_dead_transition()

func die():
	#queue_free()  # Remove the enemy from the scene when its health reaches
	sprite.visible = false

func _dead_transition():
	get_tree().change_scene_to_file(previous_scene_path)
