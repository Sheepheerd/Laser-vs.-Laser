extends Node2D
var can_animate = false
@onready var Button_movement = $Button_movement
@onready var menu_selected_option = get_parent().get_node("Menu_Options/start_menu")
func _ready():
	$Button_pop.play("start_menu_animations/Pop_in")
	await get_tree().create_timer(2).timeout
	can_animate = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_animate == true:
		#Animatinon
		if menu_selected_option.selected_option == 1:

			Button_movement.play("Play_pulse")
			
			
		elif menu_selected_option.selected_option == 2:
			
			Button_movement.play("Options_pulse")
			

			
			
		elif menu_selected_option.selected_option == 3:

			Button_movement.play("Quit_pulse")
		
