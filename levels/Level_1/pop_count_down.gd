extends Control

# Declare a countdown timer
var countdown_timer: Timer
var hide_timer: Timer
var timer_started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	countdown_timer = $countdown_timer  # Assuming you have a Timer node named "Timer"
	hide_timer = $hide_timer
	timer_started = false
	countdown_timer.timeout.connect(_on_countdown_timeout)
	countdown_timer.start(1)  # Start a 3-second countdown
	hide_timer.timeout.connect(_on_hide_timer_timeout)
	$AnimationPlayer.play("count_down_pulse")
func _on_countdown_timeout():
	var current_text = $Button.text
	if current_text == "3":
		$Button.text = "2"
	elif current_text == "2":
		$Button.text = "1"
	else:
		$Button.text = "GO"
		if timer_started == false:
			hide_timer.start(1)  # Start a 1-second timer to hide the button
			timer_started = true

func _on_hide_timer_timeout():
	$Button.hide()

