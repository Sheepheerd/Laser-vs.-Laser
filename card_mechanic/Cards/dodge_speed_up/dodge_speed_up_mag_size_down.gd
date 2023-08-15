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
	#Buff - Faster Dodge - 50% faster
	gun_controller["dodge_speed_with_gun"] = gun_controller["dodge_speed_with_gun"] + (gun_controller["dodge_speed_with_gun"] * .50)

	#Buff - Longer Dodge - 50% more
	gun_controller["dodge_distance_with_gun"] = gun_controller["dodge_distance_with_gun"] + (gun_controller["dodge_distance_with_gun"] * .50)

	#DeBuff - Magsize Smaller - 2 Less
	gun_controller["magazine_max_size"] = gun_controller["magazine_max_size"] - 2
