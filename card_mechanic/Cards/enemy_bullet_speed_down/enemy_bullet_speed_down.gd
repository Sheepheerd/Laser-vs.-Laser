extends Button

var player_index
var gun_controller
var enemy_gun_controller
func _ready():
	player_index = get_parent().player_index

	if player_index == 0:
		enemy_gun_controller = gun_tags.player_2_stats
	if player_index == 1:
		enemy_gun_controller = gun_tags.player_1_stats


func action():
	#Buff - bullet speed down - 50%
	enemy_gun_controller["bullet_speed"] = enemy_gun_controller["bullet_speed"] - (enemy_gun_controller["bullet_speed"] * .50)

