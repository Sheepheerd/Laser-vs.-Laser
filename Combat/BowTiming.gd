extends Node2D

var timer
var time_passed = 0
#define a finshed var

# Called when the node enters the scene tree for the first time.
func time_to_press():
	timer = Timer.new()
	timer.wait_time = 1
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_timeout)
	timer.start()


func _timeout():
	time_passed += 1
	print("Seconds passed: " + str(time_passed))
	if time_passed == 6:
		get_node("/root/AttackScene/User/PlayerPhase").combatPhaseFail()
		timer.queue_free()
		time_passed = 0
	
