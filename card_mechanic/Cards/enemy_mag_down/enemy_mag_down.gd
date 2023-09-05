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
	#Buff - No Enemy Bounce
	enemy_gun_controller["magazine_size"] = enemy_gun_controller["magazine_size"] - 2

