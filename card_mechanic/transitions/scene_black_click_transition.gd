extends Control

# Reference to the _AnimationPlayer_ node
@onready var _anim_player := $AnimationPlayer
func _ready():
	# Plays the animation backward to fade in
	#_anim_player.play_backwards("card_transitions/click_black")
	pass
func transition_to(_next_scene):
	# Plays the Fade animation and wait until it finishes
	_anim_player.play("card_transitions/click_black")
	await get_tree().create_timer(2).timeout
	# Changes the scene
	get_tree().change_scene_to_file(_next_scene)
