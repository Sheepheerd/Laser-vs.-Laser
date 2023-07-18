extends Area2D

# The path to the attack scene you want to load.
var attack_scene_path = "res://Combat/AttackScene.tscn"

func _on_body_entered(body):
	if body.has_method("get_enemy_tag"):
		var enemyTag = body.get_enemy_tag()
		enemy_data.current_enemy_tag = enemyTag
		enemy_data.perform_actions()
		
		var player_node = get_node("/root/OverWorld/CharacterBody2D")
		
		#Comment these out to Stop the transition
		#Load the Data
		battle_data.player_data.position = player_node.global_position #Loads the Position

		# Store the path of the enemys
		battle_data.enemy_path = body.get_path()  # Store the path of the enemy


		get_tree().change_scene_to_file(attack_scene_path)
