extends Node2D

var gun_controller
@onready var reload_timer = $reload_time
var reload_time
var player_index
var reloading = false

func _ready():
	player_index = get_parent().player_index
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	elif player_index == 1:
		gun_controller = gun_tags.player_2_stats
	reload_timer.timeout.connect(_on_reload_time_timeout)

func _process(_delta):
	if Input.is_joy_button_pressed(player_index, 3) && !reloading:
		start_reload()

	if gun_controller["magazine_size"] == 0 && !reloading:
		start_reload()

func start_reload():
	reloading = true
	get_parent().get_node("cursor").reload_finished = false
	reload_timer.wait_time = gun_controller["reload_time"]
	reload_timer.one_shot = true
	reload_timer.start()

func _on_reload_time_timeout():
	finish_reload()

func finish_reload():
	print("reloaded")
	reloading = false
	gun_controller["magazine_size"] = gun_controller["magazine_max_size"]
	get_parent().get_node("cursor").reload_finished = true
