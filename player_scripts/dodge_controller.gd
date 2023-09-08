extends CharacterBody2D
@onready var gun_controller = get_parent().get_node("gun_controller")
@onready var timer = $dodge_timer
@onready var cool_down_timer = $cooldown_timer
var cooldown = 1.3

var dashing = false
var dash_direction = Vector2.ZERO # Stores the dash direction
var dash_distance = 200
var dash_speed = 200
var raycast_1 = null
var raycast_2 = null
var raycast_3 = null

# Variables for smooth sliding
var sliding = false
var slide_time = 0.2
var slide_timer = 0.0
var initial_position = Vector2.ZERO
var target_position = Vector2.ZERO
var wait_time_after_dash
var player_index = 1
func _ready():
	
			
	# Get a reference to the RayCast2D node
	raycast_1 = $Node2D/raycast_1
	raycast_2 = $Node2D/raycast_2
	raycast_3 = $Node2D/raycast_3
		
	player_index = get_parent().player_index
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	else:
		gun_controller = gun_tags.player_2_stats
	player_index = get_parent().player_index
	cooldown = gun_controller["first_dodge_timer"]
	dash_speed = gun_controller["dodge_speed_with_gun"]
	dash_distance = gun_controller["dodge_distance_with_gun"]
	wait_time_after_dash = gun_controller["wait_time_after_dodge_timer"]
func start_dash():
	if dashing == false:
		dashing = true
		# Start the dash timer
		timer.wait_time = cooldown
		timer.one_shot = true
		timer.start()
		# Get the player's current movement direction
		var player_movement = Vector2.ZERO
		var deadzoneThreshold = 0.4

		var horizontalInput = Input.get_joy_axis(0, 0)
		var verticalInput = Input.get_joy_axis(0, 1)

		if abs(horizontalInput) > deadzoneThreshold:
			player_movement.x = 1 if horizontalInput > 0 else -1
			$Node2D.rotation_degrees = 270 if horizontalInput > 0 else 90
		else:
			player_movement.x = 0

		if abs(verticalInput) > deadzoneThreshold:
			player_movement.y = 1 if verticalInput > 0 else -1
			$Node2D.rotation_degrees = 0 if verticalInput > 0 else 180
		else:
			player_movement.y = 0

		# If the player is not moving, don't perform the dash
		player_movement = Vector2.ZERO if player_movement == Vector2.ZERO else player_movement


		# Normalize the movement direction to ensure consistent speed in all directions
		player_movement = player_movement.normalized()

		# Set the dash direction
		dash_direction = player_movement

		# Perform raycast in the dash direction
		raycast_1.force_raycast_update()
		if raycast_1.is_colliding():
			return
		raycast_2.force_raycast_update()
		if raycast_2.is_colliding():
			return
		raycast_3.force_raycast_update()
		if raycast_3.is_colliding():
			return

		# Calculate the target position after dashing
		target_position = global_position + player_movement * dash_distance

		# Start the sliding process
		sliding = true
		initial_position = global_position
		slide_timer = 0.0


#func is_dashing():
#	return !timer.is_stopped()

func stopped_timer():
	cool_down_timer.wait_time = wait_time_after_dash
	cool_down_timer.one_shot = true
	cool_down_timer.start() # Start the cooldown timer when the dash ends

func _on_cooldown_timer_timeout():
	dashing = false
	dash_direction = Vector2.ZERO # Reset the dash direction when the cooldown ends

func _process(delta):
	
	
	move_and_slide()
	if sliding:
		
		get_parent().set_collision_layer_value(5, false)
		get_parent().set_collision_mask_value(5,false)
		# Update the slide timer
		slide_timer += delta
		# Calculate the interpolation factor (0 to 1)
		var t = slide_timer / slide_time
		# Clamp the factor to 1.0 at most
		t = min(t, 1.0)
		# Smoothly interpolate between initial_position and target_position
		var new_position = initial_position + (target_position - initial_position) * t
		
		get_parent().global_position = new_position
		if raycast_1.is_colliding():
			new_position = global_position
			sliding = false
		if raycast_2.is_colliding():
			new_position = global_position
			sliding = false
		if raycast_3.is_colliding():
			new_position = global_position
			sliding = false
		# Update the global position

		# Check if sliding is complete
		if slide_timer >= slide_time:
			sliding = false
	else:
		get_parent().set_collision_layer_value(5, true)
		get_parent().set_collision_mask_value(5,true)

func _on_area_2d_body_entered(_body):
	get_parent().move_and_slide()

