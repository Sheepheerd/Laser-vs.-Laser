extends CharacterBody2D


@onready var explosion_timer = $explosion_timer
var explosion_particles = preload("res://effects/pixel_explosion.tscn")

var explosion = explosion_particles.instantiate()

var bulletVelocity = Vector2(0, 0)

var speed
var damage
var aimedAtClickPosition = false
var clickPosition = Vector2.ZERO

var direction = Vector2.ZERO
var bounce_speed
var slowDownRate
var player_index
var bullet_live_timer
var gun_controller

func _ready():
	start_timer()

	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	else:
		gun_controller = gun_tags.player_2_stats

	speed = gun_controller["grenade_speed"]
	damage =  gun_controller["damage"]
	bounce_speed = gun_controller["bounce_speed"]
	slowDownRate = gun_controller["grenade_slowdown"]

		

func start_timer():
	explosion_timer.wait_time = 2
	explosion_timer.start()

func _on_explosion_timer_timeout():
	explode()
	
func explode():

	#explosion.explode(position)
	explosion.position = position
	explosion.one_shot = true
	explosion.emitting = true
	get_parent().add_child(explosion)
	queue_free()


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


func delte_bullet():
	queue_free()

		

