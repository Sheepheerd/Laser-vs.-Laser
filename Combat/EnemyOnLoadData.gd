extends Node2D

var sprite = Sprite2D.new()
var rigidbody = RigidBody2D.new()
var collision_shape = CollisionShape2D.new()
var enemy = Node2D.new()
#Put this in the Data.gd
var shape = RectangleShape2D.new()

# Reference to the enemy script instance
var enemy_script_instance


# Called when the node enters the scene tree for the first time.
func _ready():
	# Create EnemyNode
	enemy.position = enemy_data.enemy_position
	add_child(enemy)
	enemy.name = "Enemy2"
	
	
	#Add the Enemy.gd script
	#Create instance of script
	var enemy_script_instance = load("res://Combat/Enemy.gd").new()

	enemy.add_child(enemy_script_instance)

	
	#Define Sprites
	sprite.texture = enemy_data.sprite_texture
	sprite.position = enemy_data.sprite_position
	enemy.add_child(sprite)


	#Define CollisionBox
	shape.extents = enemy_data.shape_extents1
	collision_shape.shape = shape #Change shape to be the new variable in Data.gd
	rigidbody.add_child(collision_shape)
	
	#Define Rigid Shape Position and Groupo
	rigidbody.position = enemy_data.rigidbody_position
	rigidbody.add_to_group("EnemyBody")
	rigidbody.freeze = enemy_data.rigid_frozen
	enemy.add_child(rigidbody)
	
	
	if enemy.name == "Enemy2":
		print("node has been made")


