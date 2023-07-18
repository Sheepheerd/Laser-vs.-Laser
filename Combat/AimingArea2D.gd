extends Area2D

var collided_head = null
var collided_body = null

var has_chosen = false

var aim_position = Vector2(138, 0)

@onready var aiming_node = get_node("/root/AttackScene/User/PlayerPhase/Aiming")
@onready var aim_box_sprite = get_node("/root/AttackScene/User/PlayerPhase/Aiming/AimBox")

#Set Damage Multiplier from Data.gd
var damage_multiplier = 0

func _on_ui_range_attack():
	aiming_node.position = aim_position
	aim_box_sprite.show()
	
func _on_body_entered(body):
	if get_node("/root/AttackScene/User/PlayerPhase").should_check_input == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").game_state.PLAYER_ATTACKING:
		if body.is_in_group("EnemyHead"):
			collided_head = body
		if body.is_in_group("EnemyBody"):
			print("Body")
			collided_body = body

func _on_body_exited(body):
		if get_node("/root/AttackScene/User/PlayerPhase").should_check_input == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").game_state.PLAYER_ATTACKING:
			if body == collided_head:
				collided_head = null
			if body == collided_body:
				collided_body = null

func _input(event):
		if get_node("/root/AttackScene/User/PlayerPhase").should_check_input == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").game_state.PLAYER_ATTACKING && has_chosen == false:
			if event.is_action_pressed("Back"):
				if collided_body:
					print("The Main Collision Box is Body")
					damage_multiplier = enemy_data.damage_multiplier["Body"]
					print(damage_multiplier)
					transition()
					# Add your desired code here
				elif collided_head:
					print("The Main Collision Box is Head")
					damage_multiplier = enemy_data.damage_multiplier["Head"]
					print(damage_multiplier)
					#Transition()
					# Add your desired code here
				else:
					print("Missed")
					transition()

#Create Signal For Transition
signal _transition_
func transition():
	
	has_chosen = true
	aim_box_sprite.hide()
	emit_signal("_transition_")
	
