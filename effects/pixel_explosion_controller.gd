extends CPUParticles2D

@onready var queue_timer = $queue_timer
# Called when the node enters the scene tree for the first time.
func _ready():
	queue_timer.wait_time = .75
	queue_timer.start()
	
func timer_timout():
	queue_free()

