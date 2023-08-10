extends CharacterBody2D

var speed = gun_tags.gun_stats[gun_tags.gun_tag.gatling_gun]["bullet_speed"]
var slowDownRate = gun_tags.gun_stats[gun_tags.gun_tag.gatling_gun]["bullet_slowdown"]
var damage = gun_tags.gun_stats[gun_tags.gun_tag.gatling_gun]["damage"]
var bounce_speed = gun_tags.gun_stats[gun_tags.gun_tag.gatling_gun]["bounce_speed"]
var bulletVelocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if speed > 0:
		speed = max(0, speed - slowDownRate * delta)

	# Check for collision
	var collision_info = move_and_collide(get_parent().direction * speed * delta)
	if collision_info:
		get_parent().direction = get_parent().direction.bounce(collision_info.get_normal())
		get_parent().direction.x *= bounce_speed
		get_parent().direction.y *= bounce_speed
