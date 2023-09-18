extends Node2D
var can_animate = false
@onready var Button_movement = $Button_movement
func _ready():
	#$Button_pop.play("options_menu/Pop_in")
	await get_tree().create_timer(2).timeout
	can_animate = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_animate == true:
		#Animatinon
		if get_parent().get_node("Menu_Options/sound_menu").selected_option == 1:
			pass
			#Button_movement.play("options_menu/Fullscreen_pulse")
			
#
#		elif get_parent().get_node("Menu_Options/start_menu").selected_option == 2:
#
#			Button_movement.play("Options_pulse")
#
#
#
#
#		elif get_parent().get_node("Menu_Options/start_menu").selected_option == 3:
#
#			Button_movement.play("Quit_pulse")
		
