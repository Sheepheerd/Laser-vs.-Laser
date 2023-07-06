extends Node2D


@onready var timer = Timer.new()

var timer_started = false
var reaction_time = 0.0

func melee():

	get_node("/root/AttackScene/UI").current_game_state = get_node("/root/AttackScene/UI").GameState.ENEMY_TURN


			
			
			

