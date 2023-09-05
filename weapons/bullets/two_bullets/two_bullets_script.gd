extends Node2D

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


var bullets_through_walls
#var grenade_bullets
var health
func _ready():
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	else:
		gun_controller = gun_tags.player_2_stats

#	speed = gun_controller["bullet_speed"]
#	damage =  gun_controller["damage"]
#	bounce_speed = gun_controller["bounce_speed"]
#	slowDownRate = gun_controller["bullet_slowdown"]
#	bullet_live_timer = gun_controller["bullet_live_timer"]
#	bullet_max_bounce_num = gun_controller["bullet_bounce_num"]
#	bounced_num = 0
#	vampire_bullets = gun_controller["vampire_bullets"]
#	bullets_through_walls = gun_controller["ghost_bullets"]
#	health = gun_controller["health"]


##	grenade_bullets = gun_controller["grenade_bullets"]

#func _process(delta):
#	var has_shot_timer = get_tree().create_timer(bullet_live_timer)
#	has_shot_timer.timeout.connect(delete_bullet)

#func delete_bullet():
#	queue_free()

