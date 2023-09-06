extends Area2D

var damage
var bad_player
func _ready():
	if get_parent().player_index == 0:
		bad_player = "1"
	else:
		bad_player = "0"
func _on_body_entered(body):
	damage = get_parent().damage
	if body.is_in_group("0") || body.is_in_group("1"):
		body.take_damage(damage)#pass # Replace with function body.
#		if get_parent().vampire_bullets == true && body.is_in_group(bad_player):
#			get_parent().gun_controller["health"] = get_parent().gun_controller["health"] + (damage * .5)
		get_parent().queue_free()
