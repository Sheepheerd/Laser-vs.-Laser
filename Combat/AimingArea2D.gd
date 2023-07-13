extends Area2D

var collidedHead = null
var collidedBody = null

func _on_body_entered(body):
	if get_node("/root/AttackScene/User/PlayerPhase").shouldCheckInput == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").GameState.PLAYER_ATTACKING:
		if body.is_in_group("EnemyHead"):
			collidedHead = body
		if body.is_in_group("EnemyBody"):
			collidedBody = body

func _on_body_exited(body):
	if body == collidedHead:
		collidedHead = null
	if body == collidedBody:
		collidedBody = null

func _input(event):
	if event.is_action_pressed("Back"):
		if collidedBody:
			print("The Main Collision Box is Body")
			# Add your desired code here
		elif collidedHead:
			print("The Main Collision Box is Head")
			# Add your desired code here
