extends Area2D

# The path to the attack scene you want to load.
var attack_scene_path = "res://Combat/AttackScene.tscn"

func _on_body_entered(body):
	if body.is_in_group("Enemy"): # or "Player", depending on which this script is attached to
		get_tree().change_scene_to_file(attack_scene_path)
