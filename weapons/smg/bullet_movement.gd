extends CharacterBody2D

var bulletVelocity = Vector2(0, 0)

var speed = gun_tags.gun_stats[gun_tags.gun_tag.SMG]["bullet_speed"]
var damage = gun_tags.gun_stats[gun_tags.gun_tag.SMG]["damage"]
var aimedAtClickPosition = false
var clickPosition = Vector2.ZERO
var bounce_speed = gun_tags.gun_stats[gun_tags.gun_tag.SMG]["bounce_speed"]
var direction = Vector2.ZERO

var slowDownRate = gun_tags.gun_stats[gun_tags.gun_tag.SMG]["bullet_slowdown"]
func _physics_process(delta):

	# Move the bullet
	#global_position += bulletVelocity * delta
	if speed > 0:
		speed = max(0, speed - slowDownRate * delta)

	# Check for collision
	var collision_info = move_and_collide(direction * speed * delta)
	if collision_info:
		direction = direction.bounce(collision_info.get_normal())
		direction.x *= bounce_speed
		
		direction.y *= bounce_speed
	
	var has_shot_timer = get_tree().create_timer(gun_tags.gun_stats[gun_tags.gun_tag.SMG]["gun_shoot_timer"])
	has_shot_timer.timeout.connect(delte_bullet)

func delte_bullet():
	queue_free()
