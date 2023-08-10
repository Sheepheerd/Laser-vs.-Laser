extends Node2D

var raycast = null
var aimedAtClickPosition = false
var bulletVelocity = Vector2.ZERO
var direction = Vector2.ZERO
var length = gun_tags.gun_stats[gun_tags.gun_tag.laser_boi]["ray_distance"]
# Called when the node enters the scene tree for the first time.
func _ready():
	raycast = $raycast

func _process(delta):
	if !aimedAtClickPosition:
		# Get the direction from the bullet to the click position
		# Update the bullet's velocity
		bulletVelocity = direction * length
		aimedAtClickPosition = true
	raycast.target_position = bulletVelocity
	var has_shot_timer = get_tree().create_timer(gun_tags.gun_stats[gun_tags.gun_tag.laser_boi]["gun_shoot_timer"])
	has_shot_timer.timeout.connect(delete_ray)
	
	if raycast.is_colliding():
		var collision_object = raycast.get_collider()
		if collision_object.is_in_group("player"):
			# Assuming the "collision_object" object has a "take_damage" function to handle damage
			collision_object.take_damage(gun_tags.gun_stats[gun_tags.gun_tag.laser_boi]["damage"])
		

func delete_ray():
	queue_free()
