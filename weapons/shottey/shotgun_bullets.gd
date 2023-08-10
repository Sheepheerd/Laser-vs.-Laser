extends CharacterBody2D

var bulletVelocity
var speed
var direction = Vector2.ZERO
var damage = gun_tags.gun_stats[gun_tags.gun_tag.Shottey]["damage"]
var slowDownRate = gun_tags.gun_stats[gun_tags.gun_tag.Shottey]["bullet_slowdown"]
func _physics_process(delta):
	speed = get_parent().speed
	direction = get_parent().direction
	bulletVelocity = direction * speed
	# Move the bullet
	# global_position += bulletVelocity * delta
	#global_position += bulletVelocity * delta
	if speed > 0:
		speed = max(0, speed - slowDownRate * delta)

	# Check for collision
	var collision_info = move_and_collide(bulletVelocity * speed * delta)
	if collision_info:
		print("collided")
		bulletVelocity = bulletVelocity.bounce(collision_info.get_normal())
		bulletVelocity.x *= 0.5
		bulletVelocity.y *= 0.5
