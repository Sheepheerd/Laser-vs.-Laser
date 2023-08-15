extends CPUParticles2D

@onready var queue_timer = $queue_timer
var player_index
var damage
# Called when the node enters the scene tree for the first time.
func _ready():
	queue_timer.wait_time = .5
	queue_timer.start()
	damage = get_parent().damage
func _process(delta):
	player_index = get_parent().player_index
func timer_timout():
	get_parent().queue_free()

