extends Node2D

var previous_scene_path = "res://OverWorld.tscn"  # Replace with your actual scene path

var health = enemy_data.health

@onready var sprite = get_node("/root/AttackScene/Enemy/Sprite2D")

#Script That UI_Combat Calls for Enemy Attack Phase, also sets the players attack Phase after finishing
func attack_player():
	print("You Have Been Hit")
	print("Now you must wait 3 seconds")
	await get_tree().create_timer(10.0).timeout
	print("times up")
	get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").game_state.PLAYER_TURN
	get_node("/root/AttackScene/UI")._on_back_pressed()  # Switch back to player turn
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
		await get_tree().create_timer(3).timeout
		_dead_transition()

func die():
	#queue_free()  # Remove the enemy from the scene when its health reaches 0
	enemy_data.enemy.queue_free()

func _dead_transition():
	get_tree().change_scene_to_file(previous_scene_path)
