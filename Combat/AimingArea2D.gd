extends Area2D

var collidedHead = null
var collidedBody = null

var HasChosen = false

var AimPosition = Vector2(138, 0)

@onready var Aiming_Node = get_node("/root/AttackScene/User/PlayerPhase/Aiming")
@onready var AimBoxSprite = get_node("/root/AttackScene/User/PlayerPhase/Aiming/AimBox")

func _on_ui_range_attack():
	Aiming_Node.position = AimPosition
	AimBoxSprite.show()
	
func _on_body_entered(body):
	if get_node("/root/AttackScene/User/PlayerPhase").shouldCheckInput == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING:
		if body.is_in_group("EnemyHead"):
			collidedHead = body
		if body.is_in_group("EnemyBody"):
			print("Body")
			collidedBody = body

func _on_body_exited(body):
		if get_node("/root/AttackScene/User/PlayerPhase").shouldCheckInput == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING:
			if body == collidedHead:
				collidedHead = null
			if body == collidedBody:
				collidedBody = null

func _input(event):
		if get_node("/root/AttackScene/User/PlayerPhase").shouldCheckInput == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING && HasChosen == false:
			if event.is_action_pressed("Back"):
				if collidedBody:
					print("The Main Collision Box is Body")
					Transition()
					# Add your desired code here
				elif collidedHead:
					print("The Main Collision Box is Head")
					Transition()
					# Add your desired code here
				else:
					print("Missed")
					Transition()

#Create Signal For Transition
signal _transition_
func Transition():
	
	HasChosen = true
	AimBoxSprite.hide()
	emit_signal("_transition_")
	
