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
	#Buff - Bullet Speed+ - 50% faster
	gun_controller["bullet_speed"] = gun_controller["bullet_speed"] + (gun_controller["bullet_speed"] * .70)


	#DeBuff - Reload Speed- - 20% slower
	gun_controller["reload_time"] = gun_controller["reload_time"] + (gun_controller["reload_time"] * .20)
