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
	#Buff - Player Speed+ - 20% faster
	gun_controller["speed_with_gun"] = gun_controller["speed_with_gun"] + (gun_controller["speed_with_gun"] * .20)


