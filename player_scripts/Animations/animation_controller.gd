extends AnimatedSprite2D


var player_index = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_process_controller.current_game_process == game_process_controller.game_process.game_fight:
		player_index = get_parent().player_index

		var angle = get_parent().get_node("cursor").global_position
		look_at(angle)
	#
		var vertical = Input.get_joy_axis(player_index, 1)
		var horizontal = Input.get_joy_axis(player_index, 0)
		if abs(horizontal) > 0.2 || abs(vertical) > 0.2: # Set the deadzone threshold to 0.2 (adjust as needed)
			play("walk")
		else:
			play("idle_pistol")
			
	if !game_process_controller.current_game_process == game_process_controller.game_process.game_fight:
			stop()
