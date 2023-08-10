extends Area2D


var bulletVelocity = Vector2(0, 0)
var speed = gun_tags.gun_stats[gun_tags.gun_tag.Shottey]["bullet_speed"]
var aimedAtClickPosition = false
var clickPosition = Vector2.ZERO

var move_speed = gun_tags.gun_stats[gun_tags.gun_tag.Shottey]["bullet_spread"]
var damage = gun_tags.gun_stats[gun_tags.gun_tag.Shottey]["damage"]
var fly_direction_left: Vector2 = Vector2(0, -1) # Replace with the actual flying direction
var fly_direction_right: Vector2 = Vector2(0, 2) # Replace with the actual flying direction
var fly_direction_middle: Vector2 = Vector2(0, 0)
var direction

var shake_amount = gun_tags.gun_stats[gun_tags.gun_tag.Shottey]["shake_amount"] # Adjust the shake amount as needed

func _physics_process(delta):

	if !aimedAtClickPosition:
		# Get the direction from the bullet to the click position
		# direction = get_node("/root/overworld/player/player/cursor").cursorToPlayer.normalized()
		# Update the bullet's velocity
		bulletVelocity = direction * speed
		aimedAtClickPosition = true

	# Move the bullet
	global_position += bulletVelocity * delta

	# Call the move_object_in_direction functions for bullet_1 and bullet_3
	if name == 'bullet_1':
		move_object_in_direction(get_parent().get_node("bullet_1"), fly_direction_left)
	elif name == 'bullet_2':
		move_object_in_direction(get_parent().get_node("bullet_2"), fly_direction_middle)
	elif name == 'bullet_3':
		move_object_in_direction(get_parent().get_node("bullet_3"), fly_direction_right)

func move_object_in_direction(node: Node2D, direction: Vector2):
	# Move the object to the left by subtracting the direction from its position
	node.position -= direction * move_speed
	# Add random shake to the left
	node.position += Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))

