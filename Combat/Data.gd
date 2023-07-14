extends Node2D

var Spritetexture = load("res://Sprites/ArrowSprites/Down_dir.png")
var Spriteposition = Vector2(0, 0)
var ShapeExtents1 = Vector2(0, 0)
var Rigidbody_position = Vector2(0, 0)
var Enemy_position = Vector2(0, 0)
var Rigid_frozen = true
enum EnemyTag {  # Define your enemy tags here
	ENEMY_A,
	ENEMY_B,
	ENEMY_C,
}

var currentEnemyTag = EnemyTag.ENEMY_A  # Default tag

func performActions():
	match currentEnemyTag:
		EnemyTag.ENEMY_A:
			# Perform actions for Enemy A
			print("Performing actions for Enemy A")
			Enemy_position = Vector2(0, -270)
			#var sprite = Sprite2D.new()
			Spritetexture = load("res://Sprites/ArrowSprites/Up_dir.png")
			Spriteposition = Vector2(-5, -2)
			#Shape for the Collision Shape - goes in equal distance from center out on x and y
			ShapeExtents1 = Vector2(64, 25)
			Rigidbody_position = Vector2(-5, 63)
			Rigid_frozen = true
			
		EnemyTag.ENEMY_B:
			# Perform actions for Enemy B
			print("Performing actions for Enemy B")
		EnemyTag.ENEMY_C:
			# Perform actions for Enemy C
			print("Performing actions for Enemy C")
		# Add more cases for other enemy tags if needed
