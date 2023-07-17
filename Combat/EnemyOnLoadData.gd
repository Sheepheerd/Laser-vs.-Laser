extends Node2D

var sprite = Sprite2D.new()
var rigidbody = RigidBody2D.new()
var collisionShape = CollisionShape2D.new()
var enemy = Node2D.new()
#Put this in the Data.gd
var shape = RectangleShape2D.new()

# Reference to the enemy script instance
var enemy_script_instance


# Called when the node enters the scene tree for the first time.
func _ready():
	# Create EnemyNode
	enemy.position = enemydata.Enemy_position
	add_child(enemy)
	enemy.name = "Enemy2"
	
	
	#Add the Enemy.gd script
	#Create instance of script
	var enemy_script_instance = load("res://Combat/Enemy.gd").new()

	enemy.add_child(enemy_script_instance)

	
	#Define Sprites
	sprite.texture = enemydata.Spritetexture
	sprite.position = enemydata.Spriteposition
	enemy.add_child(sprite)


	#Define CollisionBox
	shape.extents = enemydata.ShapeExtents1
	collisionShape.shape = shape #Change shape to be the new variable in Data.gd
	rigidbody.add_child(collisionShape)
	
	#Define Rigid Shape Position and Groupo
	rigidbody.position = enemydata.Rigidbody_position
	rigidbody.add_to_group("EnemyBody")
	rigidbody.freeze = enemydata.Rigid_frozen
	enemy.add_child(rigidbody)
	
	
	if enemy.name == "Enemy2":
		print("node has been made")


