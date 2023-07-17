extends Node2D

var Spritetexture = load("res://Sprites/ArrowSprites/Down_dir.png")
var Spriteposition = Vector2(0, 0)
var ShapeExtents1 = Vector2(0, 0)
var Rigidbody_position = Vector2(0, 0)
var Enemy_position = Vector2(0, 0)
var Rigid_frozen = true

#Set Enemy Health Var
var health = 0

#Setting DamageMultiplier for AimingArea2D.gd Script. This is for the different areas of the body
#Setting array up, it goes [Head, Body, Left Arm, Right Arm, Left Leg, Right Leg]
var DamageMultiplier = {"Head": 0, "Body": 0, "Left_arm": 0, "Right_arm": 0, "Left_leg": 0, "Right_leg": 0}



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
			
			#Setting Aiming Damage Multiplier
			DamageMultiplier["Head"] = 1.5
			DamageMultiplier["Body"] = 1.0
			
			#Set Health
			health = 100
			
		EnemyTag.ENEMY_B:
			# Perform actions for Enemy B
			print("Performing actions for Enemy B")
		EnemyTag.ENEMY_C:
			# Perform actions for Enemy C
			print("Performing actions for Enemy C")
		# Add more cases for other enemy tags if needed
