extends Button

var player_index
var gun_controller
func _ready():
	player_index = get_parent().player_index
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	if player_index == 1:
		gun_controller = gun_tags.player_2_stats
	
func action():
	#Buff - Max Health - +25%
	gun_controller["max_health"] = gun_controller["max_health"] + (gun_controller["max_health"] * .25)

	#DeBuff - Bullet Fire Rate - 25% slower
	gun_controller["fire_rate"] = gun_controller["fire_rate"] + (gun_controller["fire_rate"] * .25)
