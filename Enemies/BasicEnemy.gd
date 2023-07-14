extends Node

@onready var EnemyData = get_node("/root/OverWorld/EnemyData")
# Called when the node enters the scene tree for the first time.



func get_enemy_tag():
	return EnemyData.EnemyTag.ENEMY_A
	
