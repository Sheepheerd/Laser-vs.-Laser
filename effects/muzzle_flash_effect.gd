extends Node2D

var player_index
var gun_controller
var flash_position := []

func _ready():
	player_index = get_parent().player_index
	if player_index == 0:
		gun_controller = gun_tags.player_1_stats
	else:
		gun_controller = gun_tags.player_2_stats

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_flash_position()
	muzzle_flash()

func update_flash_position():
	if flash_position.size() > 0:
		$muzzle_flash.position = flash_position[0]

func muzzle_flash():
	$muzzle_flash.one_shot = true
	$muzzle_flash.emitting = true
	await get_tree().create_timer(0.1).timeout.connect(stop_muzzle_flash)

func stop_muzzle_flash():
	$muzzle_flash.emitting = false
	if flash_position.size() > 0:
		flash_position.remove_at(0)

func add_flash_position(position: Vector2):
	flash_position.append(position)

