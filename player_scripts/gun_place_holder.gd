extends Node2D

var bullet_type
var damage
var fire_rate
var reload_time
var accuracy
var magazine_size
var grenade_type
var player_index
@onready var attackTimer: Timer = get_parent().get_node("Timer")
@onready var grenade_shoot_timer: Timer = get_parent().get_node("grenade_throw_timer")
var grenade_number
var gun_controller
func _ready():
	player_index = get_parent().get_parent().player_index
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	else:
		gun_controller = gun_tags.player_2_stats
	gun_controller["grenade_num"] = gun_controller["grenade_max_num"]
	grenade_number = gun_controller["grenade_num"]
	gun_controller["magazine_size"] = gun_controller["magazine_max_size"]
	define_bullet_type()
func _process(_delta):
	if gun_controller["magazine_size"] == 0:
		magazine_empty = true
	else:
		magazine_empty = false


func grenade_throw():
	if grenade_number != 0:
		grenade_type = preload("res://weapons/grenade/grenade.tscn")
		var grenade = grenade_type.instantiate()
		get_parent().get_parent().get_parent().add_child(grenade)

		# Set the initial position of the bullet at the marker's position
		grenade.global_position = get_parent().get_node("Marker2D").global_position
		
		# Get the direction from the cursor to the player (normalized to ensure consistent speed)
		var direction = get_parent().cursorToPlayer.normalized()

		grenade_shoot_timer.wait_time = 1
			# Set the direction of the bullet
		grenade.direction = direction
		grenade_number -= 1
	
var magazine_empty = false
func weapon_fire():
	if gun_controller["magazine_size"] > 0 && !gun_controller["health"] <= 0:
		gun_controller["magazine_size"] -= gun_controller["magazine_depletion_size"]
		shoot_bullet()
		#Set Gun Fire Rate
		fire_rate = gun_controller["fire_rate"]
		attackTimer.wait_time = fire_rate
		
		#Set Magazine Size
		print(gun_controller["magazine_size"])

@onready var gun_shoot_timer = $gun_shoot_timer

var has_shot = false



func shoot_bullet():
	#get_parent().get_node("camera_shake").shoot_bullet_and_shake(player_index)
	$AudioStreamPlayer.play()
	has_shot = false
	var bullet = bullet_type.instantiate()
	bullet.player_index = player_index
	get_parent().get_parent().get_parent().add_child(bullet)


	# Set the initial position of the bullet at the marker's position
	bullet.global_position = get_parent().get_node("Marker2D").global_position
		
	# Get the direction from the cursor to the player (normalized to ensure consistent speed)
	var direction = get_parent().cursorToPlayer.normalized()

	# Apply accuracy to the direction
	#if gun_controller.current_gun_tag != gun_controller.gun_tag.Shottey:
	direction = apply_accuracy(direction, accuracy)
		# Set the direction of the bullet
	bullet.direction = direction

func apply_accuracy(dir, accuracy):
	accuracy = gun_controller["accuracy"]
	# Calculate a random angle within the specified accuracy
	var random_angle = randf_range(-accuracy, accuracy)
	
	# Rotate the direction vector by the random angle
	dir = dir.rotated(random_angle)
	
	# Normalize the direction again to maintain the desired speed
	dir = dir.normalized()

	return dir

#fix this for bullet dictionary in gun_tags
func define_bullet_type():
	
	#if gun_controller["gun_bullet"] == "1_bullet":
	bullet_type = preload("res://weapons/bullets/one_bullet/one_bullet.tscn")
#	if gun_controller["gun_bullet"] == "2_bullet":
#		bullet_type = preload("res://weapons/bullets/two_bullets/two_bullets.tscn")
#	if gun_controller["gun_bullet"] == "3_bullet":
#		bullet_type = preload("res://weapons/bullets/three_bullets/three_bullets.tscn")
#	if gun_controller["gun_bullet"] == "4_bullet":
#		bullet_type = preload("res://weapons/bullets/four_bullets/four_bullets.tscn")

#	if gun_controller["gun_bullet"] == "Grenade_Launcher":
#		bullet_type = preload("res://weapons/grenade_launcher/grenade_bullets.tscn")

