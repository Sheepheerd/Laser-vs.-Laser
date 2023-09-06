extends Control

@onready var children_P1 = get_node("Full_Hearts_P1").get_children()
@onready var children_P2 = get_node("Full_Hearts_P2").get_children()
func _ready():
	$Full_Hearts_P1.show()
	$Full_Hearts_P2.show()
	for i in range(4):
		children_P1[i].show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	#Player One
	if gun_tags.player_1_stats["health"] == 4:
		for i in range(4):
			children_P1[i].show()
	if gun_tags.player_1_stats["health"] == 3:
		for i in range(4):
			children_P1[i].hide()
		for i in range(3):
			children_P1[i].show()
	if gun_tags.player_1_stats["health"] == 2:
		for i in range(4):
			children_P1[i].hide()
		for i in range(2):
			children_P1[i].show()
	if gun_tags.player_1_stats["health"] == 1:
		for i in range(4):
			children_P1[i].hide()
		for i in range(1):
			children_P1[i].show()
	if gun_tags.player_1_stats["health"] == 0:
		$Full_Hearts_P1.hide()

	#Player Two
	if gun_tags.player_2_stats["health"] == 4:
		for i in range(4):
			children_P2[i].show()
	if gun_tags.player_2_stats["health"] == 3:
		for i in range(4):
			children_P2[i].hide()
		for i in range(3):
			children_P2[i].show()
	if gun_tags.player_2_stats["health"] == 2:
		for i in range(4):
			children_P2[i].hide()
		for i in range(2):
			children_P2[i].show()
	if gun_tags.player_2_stats["health"] == 1:
		for i in range(4):
			children_P2[i].hide()
		for i in range(1):
			children_P2[i].show()
	if gun_tags.player_2_stats["health"] == 0:
		$Full_Hearts_P2.hide()
