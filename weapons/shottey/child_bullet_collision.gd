extends CharacterBody2D

var speed
var slowDownRate
var bounce_speed
var bulletVelocity

var damage
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	speed = get_parent().speed
	slowDownRate = get_parent().slowDownRate
	bounce_speed = get_parent().bounce_speed
	damage = get_parent().damage
	
	if speed > 0:
		speed = max(0, speed - slowDownRate * delta)

	# Check for collision
	var collision_info = move_and_collide(get_parent().direction * speed * delta)
	if collision_info:
		get_parent().direction = get_parent().direction.bounce(collision_info.get_normal())
		get_parent().direction.x *= bounce_speed
		get_parent().direction.y *= bounce_speed
