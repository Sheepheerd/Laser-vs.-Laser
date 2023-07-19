extends Sprite2D


const bulletScene: = preload("res://bullet.tscn")

func _process(delta):
	# Get the global mouse position
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("left_click"):
		var bullet = bulletScene.instantiate() # Instantiate a new bullet instance
		get_node("/root/overworld").add_child(bullet)
		#get_parent().add_child(bullet)  # Add the bullet as a child of the parent node
		bullet.position = $Marker2D.global_position  # Set the bullet's initial position
		
		
		bullet.bulletVelocity = get_global_mouse_position() - bullet.position
