extends CharacterBody2D

const speed = 300.0
	
@onready var gun = get_node("/root/overworld/player/gun")
	
func _process(delta):
	#var AimBox = get_node("/root/AttackScene/Area2D")
	var player = get_node("/root/overworld/player")
	var x_direction_Left = Input.is_action_pressed("left_dir")
	var x_direction_Right = Input.is_action_pressed("right_dir")
	var y_direction_Up = Input.is_action_pressed("up_dir")
	var y_direction_Down = Input.is_action_pressed("down_dir")

	# Calculate the target position based on the current position and movement speed
	var target_position = player.position

	# Left and Right Movement
	if x_direction_Left:
		target_position.x -= speed
	elif x_direction_Right:
		target_position.x += speed
		
	# Up and Down Movement
	if y_direction_Up:
		target_position.y -= speed
	elif y_direction_Down:
		target_position.y += speed

	player.position = player.position.move_toward(target_position, speed * delta)
	
	#Flip Gun
#	if x_direction_Left:
#		gun.scale.x = -1
#	elif x_direction_Right:
#		gun.scale.x = 1
