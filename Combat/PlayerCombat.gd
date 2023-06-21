extends Node2D

var current_selection = 1
var selection_positions = []

@onready var AttackButton = get_node("/root/AttackScene/UI/AttackButton")
@onready var ItemButton = get_node("/root/AttackScene/UI/ItemButton")
@onready var RunButton = get_node("/root/AttackScene/UI/RunButton")
@onready var Cursor = get_node("/root/AttackScene/UI/Cursor")
func _ready():

	selection_positions = [AttackButton.global_position, ItemButton.global_position, RunButton.global_position]
	Cursor.global_position = selection_positions[current_selection - 1]

func _process(delta):
	if Input.is_action_just_pressed("Right_dir"):
		current_selection = (current_selection % 3) + 1
		Cursor.global_position = selection_positions[current_selection - 1]
	elif Input.is_action_just_pressed("Left_dir"):
		current_selection = ((current_selection - 2) % 3) + 1
		Cursor.global_position = selection_positions[current_selection - 1]

	if Input.is_action_just_pressed("ui_accept"):
		match current_selection:
			1:
				_on_attack_button_pressed()
			2:
				_on_item_button_pressed()
			3:
				_on_run_button_pressed()

func _on_attack_button_pressed():
	print("Attack button pressed")

func _on_item_button_pressed():
	print("Item button pressed")

func _on_run_button_pressed():
	print("Run button pressed")
