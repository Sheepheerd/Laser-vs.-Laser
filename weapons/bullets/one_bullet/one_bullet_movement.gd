extends CharacterBody2D

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

var bullet_max_bounce_num
var bounced_num

var vampire_bullets
var bullets_through_walls

#grenade bullets
#@onready var explosion_timer = $explosion_timer
#var explosion_particles = preload("res://effects/pixel_explosion.tscn")
#var explosion = explosion_particles.instantiate()
func _ready():
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	else:
		gun_controller = gun_tags.player_2_stats

	speed = gun_controller["bullet_speed"]
	damage =  gun_controller["damage"]
	bounce_speed = gun_controller["bounce_speed"]
	slowDownRate = gun_controller["bullet_slowdown"]
	bullet_live_timer = gun_controller["bullet_live_timer"]
	bullet_max_bounce_num = gun_controller["bullet_bounce_num"]
	bounced_num = 0
	vampire_bullets = gun_controller["vampire_bullets"]
	bullets_through_walls = gun_controller["ghost_bullets"]
	
	#Grenade Bullets
#	if gun_controller["grenade_bullets"] == true:
#		start_timer()
func _physics_process(delta):


	# Move the bullet
	#global_position += bulletVelocity * delta
	if speed > 0:
		speed = max(0, speed - slowDownRate * delta)

	if bullets_through_walls == true:
		set_collision_layer_value(3, false)
		set_collision_mask_value(3, false)
	if bullets_through_walls == false:
		set_collision_layer_value(3, true)
		set_collision_mask_value(3, true)
	# Check for collision
	var collision_info = move_and_collide(direction * speed * delta)
	if collision_info && bounced_num != bullet_max_bounce_num:
		bounced_num += 1
		direction = direction.bounce(collision_info.get_normal())
		direction.x *= bounce_speed
		direction.y *= bounce_speed
	
	if !collision_info && bounced_num == bullet_max_bounce_num:
		queue_free()

#	if gun_controller["grenade_bullets"] == false:
	var has_shot_timer = get_tree().create_timer(bullet_live_timer)
	has_shot_timer.timeout.connect(delete_bullet)

		
func delete_bullet():
	queue_free()


##Grenade Effect
#func start_timer():
#	explosion_timer.wait_time = 2
#	explosion_timer.start()
#
#func _on_explosion_timer_timeout():
#	explode()
#
#func explode():
#
#	#explosion.explode(position)
#	#explosion.position = position
#	explosion.one_shot = true
#	explosion.emitting = true
#	add_child(explosion)
#
#	get_node("CollisionShape2D").queue_free()
#	get_node("Sprite2D").queue_free()
#	#queue_free()
