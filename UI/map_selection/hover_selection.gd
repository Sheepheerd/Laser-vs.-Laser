extends Button




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().selected_option == 1:
		grab_focus()

	if game_process_controller.current_game_process == game_process_controller.game_process.ui_map_selection:
		if get_parent().selected_option == 2:
			get_parent().get_node("map_2").grab_focus()
		if get_parent().selected_option == 3:
			get_parent().get_node("map_3").grab_focus()
		if get_parent().selected_option == 4:
			get_parent().get_node("map_4").grab_focus()
