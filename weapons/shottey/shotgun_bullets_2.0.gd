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
	
func _process(delta):
	var has_shot_timer = get_tree().create_timer(bullet_live_timer)
	has_shot_timer.timeout.connect(delete_bullet)

func delete_bullet():
	queue_free()

