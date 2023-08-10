extends Camera2D

# The player node to follow
var player_node

@onready var target_candidates = get_tree().get_nodes_in_group("player")


func _ready():
	# Set anchor_mode to ANCHOR_MODE_FIXED_TOP_LEFT
	#anchor_mode = ANCHOR_MODE_FIXED_TOP_LEFT
	pass
func _process(delta):
	if target_candidates.size() > 0:
		# Set the offset to zero to position the camera directly on the player
		var offset = Vector2(0, 0)

		# Get the first player node from the array
		player_node = target_candidates[0]

		# Set the camera position to match the player position
		global_position = player_node.global_position + offset
