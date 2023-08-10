extends CharacterBody2D

var bullet_scene = preload("res://Enemy/enemy_bullets.tscn")  # Replace "Bullet.tscn" with the correct path to the bullet scene
var shooting_interval = 1.0  # The time interval between shots (in seconds)
var last_shot_time = 0.0

#@onready var target = get_node("/root/overworld/player/player")  # Replace "Player" with the path to the player node
var escape_speed = 100.0

var movement_speed = 100.0  # Adjust the speed as needed

@onready var attackTimer: Timer = $Timer

var has_attacked = false
var random_move_direction = Vector2.ZERO

func _ready():
	# Start the random movement timer
	$RandomMoveTimer.wait_time = randf_range(1.0, 3.0)  # Adjust the wait time as needed
	$RandomMoveTimer.start()

func _physics_process(delta):
	var target_candidates = get_tree().get_nodes_in_group("player")

	if target_candidates.size() > 0:
		# Calculate the direction towards the player
		var closest_target = target_candidates[0]
		for candidate in target_candidates:
			if candidate.global_position.distance_to(global_position) < closest_target.global_position.distance_to(global_position):
				closest_target = candidate
		var direction_to_player = (closest_target.global_position - global_position).normalized()


		# Update the rotation of the enemy to face the player (optional)
		look_at(closest_target.global_position)


		# Check if enough time has passed since the last shot
		shoot_bullet(direction_to_player)

		# Calculate the escape direction from bullets
		var escape_direction = Vector2.ZERO
		for bullet in get_tree().get_nodes_in_group("bullets"):
			if bullet.global_position.distance_to(global_position) < 100:  # Adjust the distance as needed
				escape_direction -= (bullet.global_position - global_position).normalized()

		# Move the enemy away from the bullets
		global_position += escape_direction.normalized() * escape_speed * delta

		# Move the enemy smoothly in the random move direction
		global_position += random_move_direction.normalized() * movement_speed * delta
	move_and_slide()
	
func shoot_bullet(direction):
	if !has_attacked:
		var bullet = bullet_scene.instantiate()
		get_parent().get_parent().add_child(bullet)
		bullet.position = $Marker2D.global_position
		bullet.direction = direction
		attackTimer.start()  # Start the timer after shooting a bullet
		has_attacked = true

func _on_timer_timeout():
	has_attacked = false  # Reset the flag when the timer elapses
	# Set a new random move direction
	random_move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	# Restart the timer with a new wait time for the next random move direction
	$RandomMoveTimer.wait_time = randf_range(1.0, 3.0)
	$RandomMoveTimer.start()
