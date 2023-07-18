extends Node

@onready var enemy_data = get_node("/root/OverWorld/EnemyData")
# Called when the node enters the scene tree for the first time.



func get_enemy_tag():
	return enemy_data.enemy_tag.ENEMY_A
	
