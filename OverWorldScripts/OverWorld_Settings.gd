extends Node2D

func _ready():
	# Go through all enemies
	for enemy_path in battle_data.enemy_states.keys():
		var enemy = get_node(enemy_path)
		if battle_data.enemy_states[enemy_path] == false:
			# If the enemy is marked as dead, remove or hide it
			enemy.queue_free()  # Or enemy.visible = false if you want to just hide it
			
	if str(battle_data.enemy_path) != "":
		var enemy = get_node(battle_data.enemy_path)
		enemy.queue_free()  # Or enemy.visible = false if you want to just hide it
		battle_data.enemy_states[battle_data.enemy_path] = false  # Mark the enemy as dead
		battle_data.enemy_path = ""  # Clear the path
