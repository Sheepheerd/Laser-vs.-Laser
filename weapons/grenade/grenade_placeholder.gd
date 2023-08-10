extends Node2D


var grenade_scene = preload("res://grenade.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		shoot_grenade()

	
	
func shoot_grenade():
	var grenade = grenade_scene.instantiate()
	grenade.position = position
	get_parent().add_child(grenade)
	grenade.start_timer()
