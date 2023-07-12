extends Node

var previous_scene_path = "res://OverWorld.tscn"  # Replace with your actual scene path

# Player and enemy nodes in the combat scene
@onready var player = get_node("/root/AttackScene/User/Player")  # Adjust this path according to your node hierarchy
@onready var enemy = get_node("/root/AttackScene/Enemy")

func _ready():
	# Set up the player
	#player.level = BattleData.player_data.level
	#player.weapons = BattleData.player_data.weapons
	#player.money = BattleData.player_data.money
	
	# Set up the enemy
	#enemy.level = BattleData.enemy_data.level
	#enemy.weapons = BattleData.enemy_data.weapons
	if enemy.health <= 0:
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file(previous_scene_path)
	
	


