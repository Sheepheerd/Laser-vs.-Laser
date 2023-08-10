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
	if gun_controller["gun_bullet"] == "1_bullet":
		gun_controller["gun_bullet"] = "2_bullet"
		
	elif gun_controller["gun_bullet"] == "2_bullet":
		gun_controller["gun_bullet"] = "3_bullet"
		
	elif gun_controller["gun_bullet"] == "3_bullet":
		gun_controller["gun_bullet"] = "4_bullet"
	
	else:
		gun_controller["gun_bullet"] = "1_bullet"
