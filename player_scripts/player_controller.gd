extends Node2D

const playerscene: = preload("res://player.tscn")
const cursorscene: = preload("res://cursor.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var player = playerscene.instantiate() # Instantiate a new bullet instance
	add_child(player)

