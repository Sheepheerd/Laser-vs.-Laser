extends Node

enum game_process { start_menu, options_menu, ui_map_selection, cards_selection_loser, cards_selection_winner, game_fight, game_win}
var current_game_process = game_process.start_menu


var player_death = {
		"player_1" : false,
		"player_2" : false
	}
	
var wins = {
	"player_1" : 0,
	"player_2" : 0
}

var required_wins: int = 0


var card_scene_paths = [
	"res://card_mechanic/Cards/one_plus_bullet/one_plus_bullet.tscn",
	"res://card_mechanic/Cards/dodge_speed_up/dodge_speed_up_mag_size_down.tscn",
	"res://card_mechanic/Cards/fire_rate+_accuracy-/fire_rate+_accuracy-.tscn",
	"res://card_mechanic/Cards/bullet_speed+/bullet_speed+_reload_speed_up.tscn",
	"res://card_mechanic/Cards/reload_speed+/reload_speed+_dodge_distance-.tscn",
	"res://card_mechanic/Cards/dodge_cooldown_-/dodge_cooldown_-.tscn",
	"res://card_mechanic/Cards/health-_damage+/health-_damage+.tscn",
	"res://card_mechanic/Cards/one_plus_grenade/two_plus_grenade.tscn"
	# Add more card paths here
]
