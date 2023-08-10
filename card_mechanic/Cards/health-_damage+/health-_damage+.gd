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
	#Buff - Damage - 20% more
	gun_controller["damage"] = gun_controller["damage"] + (gun_controller["damage"] * .20)

	#DeBuff - Health - 20% lower
	gun_controller["max_health"] = gun_controller["max_health"] - (gun_controller["max_health"] * .20)
