extends Area2D

@onready var gun_controller = get_parent().get_node("gun_controller")
var player_index
func _ready():
	player_index = get_parent().player_index
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	if player_index == 1:
		gun_controller = gun_tags.player_2_stats
	
func _on_body_entered(body):
	print("hello")
	if body.has_method("get_gun_tag"):
		var gun_tag = body.get_gun_tag()
		
		gun_controller["gun_bullet"] = gun_tag

