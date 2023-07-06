extends CharacterBody2D


const SPEED = 300.0

# The path to the attack scene you want to load.
#export(String, FILE, "AttackScene.tscn") var attack_scene_path
var attack_scene_path = "res://Combat/AttackScene.tscn"

func _ready():
	global_position = BattleData.player_data.position

	
func _process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction_Left = Input.is_action_pressed("Left_dir")
	var x_direction_Right = Input.is_action_pressed("Right_dir")
	var y_direction_Up = Input.is_action_pressed("Up_dir")
	var y_direction_Down = Input.is_action_pressed("Down_dir")
	
	#Left and Right Movement
	if x_direction_Left:
		velocity.x = -SPEED 
	elif x_direction_Right:
		velocity.x = SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Up and Down Movment
	if y_direction_Up:
		velocity.y = -SPEED
	elif y_direction_Down:
		velocity.y = SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_pressed("ui_accept"):
		print(BattleData.enemy_states)
	



