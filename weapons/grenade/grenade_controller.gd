extends CharacterBody2D


@onready var explosion_timer = $explosion_timer
var explosion_particles = preload("res://effects/pixel_explosion.tscn")

var explosion = explosion_particles.instantiate()
func _ready():
	start_timer()
	

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

var bulletVelocity = Vector2.ZERO

var aimedAtClickPosition = false
var clickPosition = Vector2.ZERO
#var currentSpeed = gun_controller.grenade_speed
var speed
var slowDownRate
var bounce_speed
var direction = Vector2.ZERO

#Look back at these, not needed, but should find a better way for these for grenades
var damage
var gun_shoot_timer
func _physics_process(delta):
	
	

	# Slow down the bullet gradually
	if speed > 0:
		speed = max(0, speed - slowDownRate * delta)

	# Move the bullet
	#global_position += bulletVelocity * currentSpeed * delta
	var collision_info = move_and_collide(direction * speed * delta)
	if collision_info:
		direction = direction.bounce(collision_info.get_normal())
		#velocity = velocity.bounce(collision_info.get_normal())
		direction.x *= bounce_speed
		direction.y *= bounce_speed
		
		

