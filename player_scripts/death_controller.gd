extends Node2D

var gun_controller
var player_index
var dead_player
var alive_player
var dead_player_declared = false

var targetTimeScale = 0.2
var transitionDuration = 1.0  # Adjust this to control the duration of the transition
var currentTime = 0.0
var initialTimeScale = 1.0

var rewarded_win = false
@onready var win_animation = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("win_shader/animation_controller/AnimationPlayer")
func _ready():
	dead_player_declared = false
	player_index = get_parent().player_index
	
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
		dead_player = "player_1"
		alive_player = "player_2"
		#dead_player_declared = true

	elif player_index == 1:
		gun_controller = gun_tags.player_2_stats
		dead_player = "player_2"
		alive_player = "player_1"
		#dead_player_declared = true
	game_process_controller.player_death[dead_player] = false
	game_process_controller.player_death[alive_player] = false
	initialTimeScale = Engine.time_scale
func _process(delta):
	# Fix This....this permanently changes the scene because the health is never reset
	if gun_controller["health"] <= 0 && rewarded_win == false: #&& dead_player_declared:
		game_process_controller.wins[alive_player] += 1
		player_explode()
		hide_sprite()
		dead_player_declared = false
		game_process_controller.player_death[dead_player] = true  # Update the dictionary
		gun_controller["health"] = gun_controller["max_health"]
		print("change")
		
		rewarded_win = true
		
		if game_process_controller.wins[alive_player] == game_process_controller.required_wins:
			game_process_controller.current_game_process = game_process_controller.game_process.game_win
		else:
			await get_tree().create_timer(1).timeout.connect(card_transition)

	if rewarded_win == true:
		
		win_animation.play("win_animations/win_glitch")
		currentTime += delta
		if currentTime < transitionDuration:
			# Interpolate between initialTimeScale and targetTimeScale
			Engine.time_scale = lerp(initialTimeScale, targetTimeScale, currentTime / transitionDuration)

func card_transition():
	Engine.time_scale = 1.0
	game_process_controller.current_game_process = game_process_controller.game_process.cards_selection_loser
	get_tree().change_scene_to_file("res://card_mechanic/card_selection_scenes/cards_selection_loser.tscn")
	
func player_explode():
	$player_explode/explode_flash.one_shot = true
	$player_explode/explode_flash.emitting = true

func hide_sprite():
	get_parent().get_node("AnimatedSprite2D").queue_free()

