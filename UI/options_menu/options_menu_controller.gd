extends Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Animatinon
	if get_parent().get_node("start_menu").selected_option == 1:

		#$AnimationPlayer.play("Fullscreen_pulse")
		pass
		
	elif get_parent().get_node("start_menu").selected_option == 2:
		
		#$AnimationPlayer.play("Sound_pulse")
		pass

	elif get_parent().get_node("start_menu").selected_option == 3:
		
		#$AnimationPlayer.play("Graphics_pulse")
		pass
		
	elif get_parent().get_node("start_menu").selected_option == 4:
		
		#$AnimationPlayer.play("Controls_layout_pulse")
		pass
		
	elif get_parent().get_node("start_menu").selected_option == 5:

		#$AnimationPlayer.play("Back_pulse")
		pass
