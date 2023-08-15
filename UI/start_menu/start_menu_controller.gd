extends Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Animatinon
	if get_parent().get_node("start_menu").selected_option == 1:

		$AnimationPlayer.play("Play_pulse")
		
		
	elif get_parent().get_node("start_menu").selected_option == 2:
		
		$AnimationPlayer.play("Options_pulse")
		

		
		
	elif get_parent().get_node("start_menu").selected_option == 3:

		$AnimationPlayer.play("Quit_pulse")
	
