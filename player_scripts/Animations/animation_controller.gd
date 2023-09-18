extends AnimatedSprite2D

var player_index
var move_yes

func _ready():
	player_index = get_parent().player_index
	move_yes = false

	# Set up a timer to enable player movement after 2 seconds
	var timer = Timer.new()
	timer.wait_time = 2
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(can_move_player)
	timer.start()
	if player_index == 0:
		play("1_idle_pistol")
	else:
		play("2_idle_pistol")
func _process(delta):
	if game_process_controller.current_game_process == game_process_controller.game_process.game_fight:
		update_player_animation()

	else:
		stop()

func update_player_animation():
	var angle = get_parent().get_node("cursor").global_position
	look_at(angle)

	var vertical = Input.get_joy_axis(player_index, 1)
	var horizontal = Input.get_joy_axis(player_index, 0)

	if player_index == 0:
		if abs(horizontal) < 0.2 && abs(vertical) < 0.2 || move_yes == false:
			play("1_idle_pistol")
		elif move_yes:
			if abs(horizontal) > 0.2 || abs(vertical) > 0.2:
				play("1_walk")
			elif get_parent().get_node("dodge").sliding:
				play("1_dodge")
				

	# Uncomment this block if you need similar logic for player_index == 1
	if player_index == 1:
		if abs(horizontal) < 0.2 && abs(vertical) < 0.2 || move_yes == false:
			play("2_idle_pistol")
		elif move_yes:
			if abs(horizontal) > 0.2 || abs(vertical) > 0.2:
				play("2_walk")
			elif get_parent().get_node("dodge").sliding:
				play("2_dodge")

func can_move_player():
	move_yes = true
