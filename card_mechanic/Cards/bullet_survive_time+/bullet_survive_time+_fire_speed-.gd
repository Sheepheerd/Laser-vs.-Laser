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
	#Buff - Bullet Live Timer - +3 Seconds
	gun_controller["bullet_live_timer"] = gun_controller["bullet_live_timer"] + 3

	#DeBuff - Bullet Fire Rate - 25% slower
	gun_controller["fire_rate"] = gun_controller["fire_rate"] + (gun_controller["fire_rate"] * .25)
