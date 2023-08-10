extends Area2D

var canshoot = true
var cursorSpeed: float = 250.0
var cursorToPlayer = Vector2.ZERO
var cursorDistance: float = 15.0
var rightStickThreshold: float = 0.5

@onready var attackTimer: Timer = $Timer

var originalPosition: Vector2
var dashing = false
var rightStick
var player_index = 1

var has_selected = false
func _ready():
	#gun_controller.perform_actions()
	originalPosition = position # Store the original position of the cursor
	#magazine_size = gun_controller.magazine_size

	if Input.is_joy_button_pressed(player_index, 0) == true:
		has_selected = true
	player_index = get_parent().player_index
##Handles shooting, grenades, and curser distance for right controller stick
func _process(delta):
	if 	game_process_controller.current_game_process == game_process_controller.game_process.game_fight:
		if Input.is_joy_button_pressed(player_index, 0) == false:
			has_selected = false
	
	if Input.get_joy_axis(player_index, 5) && has_selected == false:
		Attack()

	if Input.is_joy_button_pressed(player_index, 10)  && has_selected == false:
		shoot_grenade()
	# Controller Support
	rightStick = Vector2(
		Input.get_joy_axis(player_index, 2),
		Input.get_joy_axis(player_index, 3)
	)

	# Apply the threshold for the right stick input
	if rightStick.length() < rightStickThreshold:
		rightStick = Vector2.ZERO
	elif rightStick.length() > rightStickThreshold:
		position += rightStick * cursorSpeed * delta

	# Move the cursor based on the right stick input
	position += rightStick * cursorSpeed * delta

	# Ensure the cursor stays within the specified distance from the player
	cursorToPlayer = position
	if cursorToPlayer.length() > cursorDistance:
		position = cursorToPlayer.normalized() * cursorDistance





#if the cursor is inside the player, then the player can't shoot
func _on_body_entered(_body):
	canshoot = false
#if the cursor is outside the player, then the player can't shoot
func _on_body_exited(_body):
	canshoot = true

#Sets up timing for gun so the player can't just spam bullets every frame
var has_attacked = false
var reload_finished = true
func Attack():
	#if canshoot && !has_attacked && magazine_size > 0 && reload_finished == true:
	if canshoot && !has_attacked && reload_finished == true:
		$gun_place_holder.weapon_fire()
		#Sets up Bullet Position and Direction
		has_attacked = true
		attackTimer.start() # Start the timer after shooting a bullet

func _on_Timer_timeout():
	has_attacked = false # Reset the flag when the timer elapses



#Sets up Grenades
#var grenade_scene = preload("res://weapons/grenade/grenade.tscn")
var grenade_number
var has_thrown = false
@onready var grenade_throw_timer = $grenade_throw_timer
func shoot_grenade():
	if canshoot && !has_thrown && !has_attacked && reload_finished == true:
		$gun_place_holder.grenade_throw()
		has_thrown = true
		grenade_throw_timer.start() 



func _on_grenade_thown_timer_timeout():
	has_thrown = false
