extends CharacterBody2D

var gun_controller

#set Player number
var player_index

var cursorSpeed: float = 1000.0

#const dashspeed = 100
var dashlength # how long the dash lasts in seconds
var speed

var has_selected
#var velocity = Vector2.ZERO
@onready var dash = $dodge
var health
var player_tag = self.get_name()
func _ready():
	# Hide the system mouse cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	else:
		gun_controller = gun_tags.player_2_stats
	
	if Input.is_joy_button_pressed(player_index, 0) == true:
		has_selected = true


	game_process_controller.can_pause = true
	#Setting Health
	gun_controller["health"] = gun_controller["max_health"]

func _physics_process(delta):
	if game_process_controller.current_game_process == game_process_controller.game_process.game_fight && !gun_controller["health"] <= 0:
		if Input.is_joy_button_pressed(player_index, 0) == false:
			has_selected = false
	
		#Gun effects
		speed = gun_controller["speed_with_gun"]

		var move_dir = Vector2.ZERO
		if Input.is_joy_button_pressed(player_index, 0) && has_selected == false && get_node("dodge").dashing == false:
			dash.start_dash()
	#	if dash.is_dashing():
	#		return

		# Controller input
		var horizontal = Input.get_joy_axis(player_index, 0)
		if abs(horizontal) > 0.2: # Set the deadzone threshold to 0.2 (adjust as needed)
			move_dir.x += horizontal
		else:
			move_dir.x = 0.0
		var vertical = Input.get_joy_axis(player_index, 1)
		if abs(vertical) > 0.2: # Set the deadzone threshold to 0.2 (adjust as needed)
			move_dir.y += vertical
		else:
			move_dir.y = 0.0
			

		# Calculate the total input strength (length of the move_dir vector)
		var input_strength = move_dir.length()

		# Normalize the move_dir vector to ensure consistent movement speed in all directions
		move_dir = move_dir.normalized()

		# Adjust the speed based on input strength, you can experiment with different scaling factors
		var scaled_speed = speed * (1.0 + input_strength * 2.0)

		# Calculate the target velocity based on the current input and movement speed
		var target_velocity = move_dir * scaled_speed

		# Gradually adjust the current velocity towards the target velocity
		velocity = velocity.lerp(target_velocity, .3) # Adjust the second argument to control the slowdown rate

		# Calculate the target position based on the current position and movement velocity
		var target_position = position + velocity * delta

		position = position.move_toward(target_position, velocity.length() * delta)
		move_and_slide()
		
		if Input.is_action_just_pressed("E"):
			print(gun_controller["health"])
			
		pause_menu()
			
func take_damage(damage):

	gun_controller["health"] -= damage


func pause_menu():
	if Input.is_joy_button_pressed(player_index, 5) == true && game_process_controller.can_pause == true:
		game_process_controller.current_game_process = game_process_controller.game_process.pause_menu
		get_tree().paused = true
