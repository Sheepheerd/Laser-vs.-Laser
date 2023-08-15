extends CharacterBody2D

var speed
var slowDownRate
var bounce_speed
var bulletVelocity

var damage
var bullet_max_bounce_num
var bounced_num
var vampire_bullets
var player_index
var health
var bullet_live_timer
var bullets_through_walls
##Grenade Effects
#@onready var explosion_timer = $explosion_timer
#var explosion_particles = preload("res://effects/pixel_explosion.tscn")
#var explosion = explosion_particles.instantiate()
var gun_controller
func _ready():
	player_index = get_parent().player_index
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	else:
		gun_controller = gun_tags.player_2_stats

#	#Grenade Bullets
#	if get_parent().grenade_bullets == true:
#		start_timer()
func _physics_process(delta):
	speed = gun_controller["bullet_speed"]
	damage =  gun_controller["damage"]
	bounce_speed = gun_controller["bounce_speed"]
	slowDownRate = gun_controller["bullet_slowdown"]
	bullet_live_timer = gun_controller["bullet_live_timer"]
	bullet_max_bounce_num = gun_controller["bullet_bounce_num"]
	bounced_num = 0
	vampire_bullets = gun_controller["vampire_bullets"]
	bullets_through_walls = gun_controller["ghost_bullets"]
	health = gun_controller["health"]
	
#	grenade_bullets = gun_controller["grenade_bullets"]

	if speed > 0:
		speed = max(0, speed - slowDownRate * delta)

	if bullets_through_walls == true:
		set_collision_layer_value(3, false)
		set_collision_mask_value(3, false)
	if bullets_through_walls == false:
		set_collision_layer_value(3, true)
		set_collision_mask_value(3, true)
		
	# Check for collision
	var collision_info = move_and_collide(get_parent().direction * speed * delta)
	if collision_info && get_parent().bounced_num != bullet_max_bounce_num:
		bounced_num += 1
		get_parent().direction = get_parent().direction.bounce(collision_info.get_normal())
		get_parent().direction.x *= bounce_speed
		get_parent().direction.y *= bounce_speed
	
	if !collision_info && get_parent().bounced_num == bullet_max_bounce_num:
		queue_free()
	
	
#	if get_parent().grenade_bullets == false:
	var has_shot_timer = get_tree().create_timer(bullet_live_timer)
	has_shot_timer.timeout.connect(delete_bullet)
		
func delete_bullet():
	queue_free()
	
	

#	#Grenade Bullets
#	if get_parent().grenade_bullets == true:
#		start_timer()
#
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
#	get_parent().add_child(explosion)
#
#	get_node("CollisionShape2D").queue_free()
#	get_node("Sprite2D").queue_free()
#	#queue_free()
