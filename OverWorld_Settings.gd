extends Node2D

func _ready():
	# Go through all enemies
	for enemy_path in BattleData.enemy_states.keys():
		var enemy = get_node(enemy_path)
		if BattleData.enemy_states[enemy_path] == false:
			# If the enemy is marked as dead, remove or hide it
			enemy.queue_free()  # Or enemy.visible = false if you want to just hide it
			
	if str(BattleData.enemy_path) != "":
		var enemy = get_node(BattleData.enemy_path)
		enemy.queue_free()  # Or enemy.visible = false if you want to just hide it
		BattleData.enemy_states[BattleData.enemy_path] = false  # Mark the enemy as dead
		BattleData.enemy_path = ""  # Clear the path
