extends Node2D

var sprite = Sprite2D.new()
var rigidbody = RigidBody2D.new()
var collisionShape = CollisionShape2D.new()
var enemy = Node2D.new()
#Put this in the Data.gd
var shape = RectangleShape2D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	# Create EnemyNode
	enemy.position = Data.Enemy_position
	add_child(enemy)
	enemy.name = "Enemy2"

	
	#Define Sprites
	sprite.texture = Data.Spritetexture
	sprite.position = Data.Spriteposition
	enemy.add_child(sprite)


	#Define CollisionBox
	shape.extents = Data.ShapeExtents1
	collisionShape.shape = shape #Change shape to be the new variable in Data.gd
	rigidbody.add_child(collisionShape)
	
	#Define Rigid Shape Position and Groupo
	rigidbody.position = Data.Rigidbody_position
	rigidbody.add_to_group("EnemyBody")
	rigidbody.freeze = Data.Rigid_frozen
	enemy.add_child(rigidbody)
	
	
	if enemy.name == "Enemy2":
		print("node has been made")


