extends Node

#Define the Scene
var previous_scene_path = "res://CharacterTest.tscn"  # Replace with your actual scene path

var player_data = {
	"level": 0,
	"weapons": [],
	"money": 0
}

var enemy_data = {
	"level": 0,
	"weapons": []
}

var enemy_path = ""  # Path of the enemy that initiated the combat

func _ready():
	var player_node = get_node("/root/OverWorld/CharacterBody2D")
	player_data.position = player_node.global_position

# New: Dictionary to keep track of the state of the enemies
var enemy_states = {}
