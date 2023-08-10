extends Area2D

var damage

func _on_body_entered(body):
	damage = get_parent().damage
	if body.is_in_group("player"):
		body.take_damage(damage)#pass # Replace with function body.
