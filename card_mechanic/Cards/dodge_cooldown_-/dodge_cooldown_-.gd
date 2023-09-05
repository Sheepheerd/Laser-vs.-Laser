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
	#Buff - dodge_cooldown+ - 50% faster
	gun_controller["first_dodge_timer"] = gun_controller["first_dodge_timer"] - (gun_controller["first_dodge_timer"] * .5)
	gun_controller["wait_time_after_dodge_timer"] = gun_controller["wait_time_after_dodge_timer"] - gun_controller["wait_time_after_dodge_timer"] * .5


