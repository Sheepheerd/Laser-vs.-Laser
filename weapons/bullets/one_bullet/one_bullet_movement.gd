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

var is_dead = false

func _ready():
	is_dead = false
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
	
	if !collision_info && bounced_num == bullet_max_bounce_num && is_dead == false:
		bullet_crash()
		delete_bullet()


		
func delete_bullet():
	is_dead = true
	$CollisionShape2D.queue_free()
	$Sprite2D.queue_free()
	$damage.queue_free()
	#position = Vector2(1000, 2000)
	cpu_trail()
	get_tree().create_timer(2).timeout.connect(_delete)
	#queue_free()

func bullet_crash():
	$bullet_crash.get_node("bullet_crash").one_shot = true
	$bullet_crash.get_node("bullet_crash").emitting = true
	speed = 0
	await get_tree().create_timer(1).timeout.connect(stop_bullet_crash)

func stop_bullet_crash():
	$bullet_crash.get_node("bullet_crash").emitting = false

	
func cpu_trail():
	$cpu_trail.get_node("cpu_trail").gravity.x = 0
	$cpu_trail.get_node("cpu_trail").emitting = false

func _delete():
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
