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
