extends Node2D
var can_animate = false
@onready var Button_movement = $button_animations
@onready var menu_selected_option = get_parent().get_node("Menu_options/map_menu")
func _ready():
	$Button_pop.play("map_selection/Pop_in")
	await get_tree().create_timer(2).timeout
	can_animate = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_animate == true:
		#Animatinon
		if menu_selected_option.selected_option == 1:

			Button_movement.play("map_selection/map_1_pulse")
			
			
		elif menu_selected_option.selected_option == 2:
			
			Button_movement.play("map_selection/map_2_pulse")
			

			
			
		elif menu_selected_option.selected_option == 3:

			Button_movement.play("map_selection/map_3_pulse")
		
		elif menu_selected_option.selected_option == 4:

			Button_movement.play("map_selection/map_4_pulse")
