extends Node2D

var gun_controller
@onready var reload_timer = $reload_time
var reload_time
var player_index
var reloading = false

var targetValue: float = 0.0
var currentTime = 0
var lerpDuration = 2.5  # Set the lerp duration to 2.5 seconds
var maxSliderValue: float = 100.0  # Replace this with your actual maximum slider value

func _ready():
	player_index = get_parent().player_index
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	elif player_index == 1:
		gun_controller = gun_tags.player_2_stats
	reload_timer.timeout.connect(_on_reload_time_timeout)

	$HSlider.value = 0.0
	
func _process(delta):
	if Input.is_joy_button_pressed(player_index, 3) && !reloading:
		start_reload()
		startLerp(maxSliderValue)

	if gun_controller["magazine_size"] == 0 && !reloading:
		start_reload()
		
	if reloading:
		# Calculate the interpolation factor (0 to 1)
		var t = currentTime / lerpDuration
		# Perform the linear interpolation
		currentTime += delta
		$HSlider.value = lerp(0.0, targetValue, t)
	else:
		# Ensure we reach the exact target value when the lerp is complete
		$HSlider.value = 0

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

func startLerp(target):
	targetValue = target
	currentTime = 0
