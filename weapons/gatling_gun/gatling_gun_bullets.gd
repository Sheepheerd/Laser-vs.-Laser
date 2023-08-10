extends Node2D

var bulletVelocity = Vector2(0, 0)
var speed
#var speed = gun_tags.gun_stats[gun_tags.gun_tag.Shottey]["bullet_speed"]
var aimedAtClickPosition = false
var clickPosition = Vector2.ZERO

var damage = gun_tags.gun_stats[gun_tags.gun_tag.gatling_gun]["damage"]
var fly_direction_left: Vector2 = Vector2(0, -1) # Replace with the actual flying direction
var fly_direction_right: Vector2 = Vector2(0, 2) # Replace with the actual flying direction
var fly_direction_middle: Vector2 = Vector2(0, 0)
var direction


var slowDownRate = gun_tags.gun_stats[gun_tags.gun_tag.gatling_gun]["bullet_slowdown"]

func _process(delta):
	var has_shot_timer = get_tree().create_timer(gun_tags.gun_stats[gun_tags.gun_tag.gatling_gun]["gun_shoot_timer"])
	has_shot_timer.timeout.connect(delte_bullet)

func delte_bullet():
	queue_free()
