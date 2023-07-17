extends Node2D

var timer
var time_passed = 0
#define a finshed var
var finished = false
# Called when the node enters the scene tree for the first time.
func time_to_press():
	timer = Timer.new()
	timer.wait_time = .5
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_timeout)
	timer.start()
	
	finished = false


func _timeout():
	time_passed += .5
	print("Seconds passed: " + str(time_passed))
	if time_passed == 6:
		timer.stop()
		timer.queue_free()
		time_passed = 0
		finished = true
		get_node("/root/AttackScene/User/PlayerPhase").combat_phase_fail.emit()

	elif get_node("/root/AttackScene/User/PlayerPhase").has_attacked == true:
		timer.stop()
		timer.queue_free()
		time_passed = 0
		print("has attacked")
		#finished = true

	else:
		print("Neither Conditions are met")
