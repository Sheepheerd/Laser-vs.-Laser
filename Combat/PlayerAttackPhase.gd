extends Node2D

class button_sprite extends Sprite2D:
	var metadata: int

#The Buttons That will be displayed, add duplicates to enable the randomness.
var original_button_inputs = ["Up_dir", "Down_dir", "Up_dir", "Down_dir"]
var shuffled_button_inputs = []  # Holds the shuffled button inputs for each combat phase

#Button Index
var current_input_index = 0

#If enabled, then will proceed with Button Input Phase
var should_check_input = false
var should_collision_enable = false
# Defining Signal
signal player_attack

signal combat_phase_success
signal combat_phase_fail

#Defining If the player has attacked so that it can end the timer in BowTiming.gd
var has_attacked = false

#Define the correctnessPercent
var correctness_percent = 0

#Define DamageMultiplier Var
var damage_multiplier = 0.0
var damage = 0.0
var has_done_d_calc = false
var final_damage = 0.0
var adjusted_damage = 0.0

#Fix This Later - This should be dependant on the weapon of the user/level
var base_damage = 0.0

# Placeholder For Attack
var has_done_damage = false

func _ui_range_attack():
	var UI = get_node("/root/AttackScene/UI")
	if UI.current_game_state == UI.game_state.PLAYER_ATTACKING && get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").has_chosen == true:
		buttons()

		await get_tree().create_timer(2.0).timeout


func buttons():
	var bow_timer = get_node("/root/AttackScene/User/PlayerPhase/Bow")
	
	#Set up Bow Timer
	bow_timer.time_to_press()
	shuffled_button_inputs = shuffle_array(original_button_inputs)  # Shuffle the original buttonInputs array
	show_button_sprites()
	has_attacked = false

func show_button_sprites():
	
	var sprite_positions = [
		Vector2(-400, 0),  # First column
		Vector2(-100, 0),  # Second column
		Vector2(100, 0),   # Third column
		Vector2(400, 0)    # Fourth column
	]
	var sprite_indices = shuffle_array(range(shuffled_button_inputs.size()))

	for i in range(original_button_inputs.size()):
		var sprite = button_sprite.new()
		sprite.texture = load("res://Sprites/ArrowSprites/" + shuffled_button_inputs[sprite_indices[i]] + ".png")
		sprite.position = sprite_positions[sprite_indices[i]]
		sprite.metadata = sprite_indices[i]  # Assign the index as metadata
		add_child(sprite)

# Defines if can input, then if can, then goes to _CheckInput
func _input(event):
	can_input(event)
	
func can_input(event):
	#If it is the Players Turn, These are the set of conditions.
	if get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").game_state.PLAYER_ATTACKING:
		if Input.is_action_pressed("Up_dir") == false and \
		   Input.is_action_pressed("Down_dir") == false and \
		   Input.is_action_pressed("Left_dir") == false and \
		   Input.is_action_pressed("Right_dir") == false:
			should_check_input = false
		elif get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").has_chosen == true:
			should_check_input = true #should be true
		
		if should_check_input:
			check_input(event)

func check_input(event):
	
	if event is InputEventKey && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").game_state.PLAYER_ATTACKING:
		if Input.is_action_just_pressed(shuffled_button_inputs[current_input_index]):
			var sprite_index = current_input_index

			# Find the sprite with the corresponding index
			var sprite = find_button_sprite_by_index(sprite_index)
			if sprite:
				sprite.queue_free()

			current_input_index += 1
			
			correctness_percent += 10.0

			if current_input_index >= shuffled_button_inputs.size():
				current_input_index = 0
				should_check_input = false
				has_attacked = true
				combat_phase_success.emit()

		else:
			combat_phase_fail.emit()

func find_button_sprite_by_index(index: int) -> button_sprite:
	for child in get_children():
		if child is button_sprite and child.metadata == index:
			return child
	return null

func combat_phase_success_fc():
	# Code for successful completion of the combat phase
	print("Combat phase success!")
	get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").has_chosen = false
	if has_done_d_calc == false:
		damage_calculation()
	if has_done_d_calc == true:
		kill_enemy()
	if has_done_damage == true:
		get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").game_state.ENEMY_TURN

func combat_phase_fail_fc():
	# Code for failure in the combat phase
	# Hide all ButtonSprite children
	current_input_index = 0
	for child in get_children():
		if child is button_sprite:
			child.queue_free()
	
	get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D").has_chosen = false
	should_check_input = false
	if has_done_d_calc == false:
		damage_calculation()
	if has_done_d_calc == true:
		kill_enemy()
	if has_done_damage == true:
		get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").game_state.ENEMY_TURN

func shuffle_array(array):
	var shuffled_array = array.duplicate()
	for i in range(shuffled_array.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = shuffled_array[i]
		shuffled_array[i] = shuffled_array[j]
		shuffled_array[j] = temp
	return shuffled_array


func damage_calculation():
	if has_done_d_calc == false:
		has_done_damage = false
		#Define Base Damage (This should be equal to the damage of the weapon the player holds)
		base_damage = 100.0

		#Define the AimNode
		var aim_node = get_node("/root/AttackScene/User/PlayerPhase/Aiming/Area2D")
		damage_multiplier = aim_node.damage_multiplier
		#Adjust The damage by the multiplier
		adjusted_damage = base_damage * damage_multiplier
		final_damage = adjusted_damage * (correctness_percent / 100)
		damage = final_damage
		print(final_damage)
		has_done_d_calc = true
		
	
func kill_enemy():
	if has_done_d_calc == true && has_done_damage == false:
		var enemy = get_node("/root/AttackScene/Enemy")  # Adjust this path according to your node hierarchy
		enemy.take_damage(damage)  # Damage the enemy by its own health amount, effectively killing it
		has_done_d_calc = false
		has_done_damage = true
		#Reset Correctnesspercent back to 0 so combat values can be default for player's turn
		correctness_percent = 0.0
		print(enemy.health)
		#has_attacked = false

			
#Aim Movement
func _process(delta):
	if should_check_input == false && get_node("/root/AttackScene/UI").current_game_state == get_node("/root/AttackScene/UI").game_state.PLAYER_ATTACKING:
		const speed = 300.0
		#var AimBox = get_node("/root/AttackScene/Area2D")
		var aim_box = get_node("/root/AttackScene/User/PlayerPhase/Aiming")
		var x_direction_Left = Input.is_action_pressed("Left_dir")
		var x_direction_Right = Input.is_action_pressed("Right_dir")
		var y_direction_Up = Input.is_action_pressed("Up_dir")
		var y_direction_Down = Input.is_action_pressed("Down_dir")

		# Calculate the target position based on the current position and movement speed
		var target_position = aim_box.position

		# Left and Right Movement
		if x_direction_Left:
			target_position.x -= speed
		elif x_direction_Right:
			target_position.x += speed

		# Up and Down Movement
		if y_direction_Up:
			target_position.y -= speed
		elif y_direction_Down:
			target_position.y += speed

		aim_box.position = aim_box.position.move_toward(target_position, speed * delta)
