extends Node

enum game_process { start_menu, options_menu, ui_map_selection, ui_lobby,sound_menu, pause_menu, cards_selection_loser, cards_selection_winner, game_fight, game_win}
#var current_game_process = game_process.start_menu --- #Should be this
var current_game_process = game_process.game_fight

var game_lobby = {
	"player_1" : false,
	"player_2" : false,
	"full_lobby" : false
}

var player_death = {
		"player_1" : false,
		#"player_1" : false,
		"player_2" : false
	}
	
var wins = {
	"player_1" : 0,
	"player_2" : 0
}

var master_value : int = 0
var music_value : int = -5
var sfx_value : int = 0

func _process(delta):


	if music_value == -15:
		AudioServer.set_bus_volume_db(1, -80)
		AudioServer.set_bus_volume_db(2, -80)
	else:
		AudioServer.set_bus_volume_db(1, music_value * 2.5)
		AudioServer.set_bus_volume_db(2, sfx_value)

	
	

func load_config():

	var config = ConfigFile.new()
	
	if config.load("res://settings.cfg") == OK:
		var fullscreen = config.get_value("Settings", "Fullscreen", false)
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

		music_value = config.get_value("Audio_music", "Music_value", music_value)
		sfx_value = config.get_value("Audio_Sfx", "Sfx_value", sfx_value)

func save_config():
	var config = ConfigFile.new()
	
	config.set_value("Settings", "Fullscreen", DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN)
	config.set_value("Audio_music", "Music_value", music_value)
	config.set_value("Audio_Sfx", "Sfx_value", sfx_value)

	config.save("res://settings.cfg")

var not_playing_game_music = true

var required_wins: int = 3
var can_pause: bool = true
var shake_timer = 0.0

var card_scene_paths = [
	##Dodge Affects
	"res://card_mechanic/Cards/dodge_speed_up/dodge_speed_up_mag_size_down.tscn",
	"res://card_mechanic/Cards/dodge_cooldown_-/dodge_cooldown_-.tscn",
	
	##Bullet Affects
	"res://card_mechanic/Cards/enemy_bullet_speed_down/enemy_bullet_speed_down.tscn",
	"res://card_mechanic/Cards/bullet_speed_up_on_bounce/bullet_speed_up_on_bounce.tscn",
	"res://card_mechanic/Cards/fire_rate+_accuracy-/fire_rate+_accuracy-.tscn",
	"res://card_mechanic/Cards/bullet_speed+/bullet_speed+_reload_speed_up.tscn",
	"res://card_mechanic/Cards/bullet_bounce+2/bullet_bounce+2.tscn",
	"res://card_mechanic/Cards/acc+_fire_rate+_bullet_bounce-/acc+_fire_rate+.tscn",

#	##Gun Affects
	"res://card_mechanic/Cards/reload_speed+/reload_speed+.tscn",
	"res://card_mechanic/Cards/mag_size+/mag_size+_dodge_cooldown_up.tscn",

#	##Player Affects
	"res://card_mechanic/Cards/enemy_no_dodge/enemy_no_dodge.tscn",
	"res://card_mechanic/Cards/enemy_speed_down/enemy_speed_down.tscn",
	"res://card_mechanic/Cards/enemy_mag_down/enemy_mag_down.tscn",
	#"res://card_mechanic/Cards/extra_life/extra_life.tscn",
	"res://card_mechanic/Cards/player_speed_up/player_speed_up.tscn",


#	##Bullet Abilities
	"res://card_mechanic/Cards/bullet_speed_down_on_bounce/bullet_speed_down_on_bounce.tscn",
	"res://card_mechanic/Cards/enemy_no_bounce/enemy_no_bounce.tscn",
	#"res://card_mechanic/Cards/one_plus_bullet/one_plus_bullet.tscn",
	"res://card_mechanic/Cards/ghost_bullets/ghost_bullets.tscn"

	# Add more card paths here
]
