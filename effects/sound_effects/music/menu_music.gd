extends Node

var menu_music = load("res://effects/sound_effects/music/This is the Song(Not mine).ogg")
var fade_duration = 2.0  # Adjust this to control the fade duration in seconds
var music_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_music():

	if !$Music.stream:
		$Music.stream = menu_music
#	if !$Music.playing:
	$Music.play()
	#$Music.volume_db = -15.0  # Start with low volume
	$AnimationPlayer.play("FadeIn")


func stop_music():
	$AnimationPlayer.play_backwards("FadeIn")
	await get_tree().create_timer(2).timeout.connect(stop_song)

func stop_song():
	$Music.stop()
# This function is connected to the AnimationPlayer's "animation_finished" signal
#func on_animation_finished(anim_name):
#	if anim_name == "FadeIn":
#		$Music.volume_db = 0.0  # Set volume to full after fade-in
#	elif anim_name == "FadeOut":
#		$Music.stop()
#		$Music.volume_db = -15.0  # Reset volume to low after fade-out
