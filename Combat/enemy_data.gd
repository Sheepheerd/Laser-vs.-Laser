extends Node2D

var sprite_texture = load("res://Sprites/ArrowSprites/Down_dir.png")
var sprite_position = Vector2(0, 0)
var shape_extents1 = Vector2(0, 0)
var rigidbody_position = Vector2(0, 0)
var enemy_position = Vector2(0, 0)
var rigid_frozen = true

#Set Enemy Health Var
var health = 200

#Setting DamageMultiplier for AimingArea2D.gd Script. This is for the different areas of the body
#Setting array up, it goes [Head, Body, Left Arm, Right Arm, Left Leg, Right Leg]
var damage_multiplier = {"Head": 0, "Body": 0, "Left_arm": 0, "Right_arm": 0, "Left_leg": 0, "Right_leg": 0}



enum enemy_tag {  # Define your enemy tags here
	ENEMY_A,
	ENEMY_B,
	ENEMY_C,
}

var current_enemy_tag = enemy_tag.ENEMY_A  # Default tag

func perform_actions():
	match current_enemy_tag:
		enemy_tag.ENEMY_A:
			# Perform actions for Enemy A
			print("Performing actions for Enemy A")
			enemy_position = Vector2(0, -270)
			#var sprite = Sprite2D.new()
			sprite_texture = load("res://Sprites/ArrowSprites/Up_dir.png")
			sprite_position = Vector2(-5, -2)
			#Shape for the Collision Shape - goes in equal distance from center out on x and y
			shape_extents1 = Vector2(64, 25)
			rigidbody_position = Vector2(-5, 63)
			rigid_frozen = true
			
			#Setting Aiming Damage Multiplier
			damage_multiplier["Head"] = 1.5
			damage_multiplier["Body"] = 1.0
			
			#Set Health
			health = 100
			
		enemy_tag.ENEMY_B:
			# Perform actions for Enemy B
			print("Performing actions for Enemy B")
		enemy_tag.ENEMY_C:
			# Perform actions for Enemy C
			print("Performing actions for Enemy C")
		# Add more cases for other enemy tags if needed
