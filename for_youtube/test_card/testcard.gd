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
	#Buff - Fire Rate - 30% faster
	gun_controller["fire_rate"] = gun_controller["fire_rate"] - (gun_controller["fire_rate"] * .30)

	#Buff - Accuracy - 20% smaller error
	gun_controller["accuracy"] = gun_controller["accuracy"] - (gun_controller["accuracy"] * .2)


