extends Area2D

signal enemy_collision

#func _ready():
	#connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	print("hello")
	if body.is_in_group("Head"):
		print("Collision with Enemy")
		emit_signal("enemy_collision")
	else:
		print("Nothing")
