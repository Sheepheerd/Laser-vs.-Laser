extends Node2D


var player_1_stats = {
			"damage": 10,
			"bullet_speed": 1000,
			"bullet_slowdown" : 250,
			"bullet_live_timer" : 2,
			"bounce_speed" : .9,
			"fire_rate" : 0.8, # per second
			"reload_time" : 2.5, # seconds
			"magazine_size" : 10, # bullets
			"accuracy" : 0.03, # try to implement some sort of random spray
			"magazine_depletion_size" : 1,
			"speed_with_gun" : 90,
			"wait_time_after_dodge_timer" : 1,
			"dodge_speed_with_gun" : 200,
			"dodge_distance_with_gun" : 200,
			"first_dodge_timer" : 1,
			"health" : 100,
			"gun_bullet" : "1_bullet",
			"magazine_max_size" : 10
	}
	
var player_1_stats_defaults = {
			"damage": 10,
			"bullet_speed": 1000,
			"bullet_slowdown" : 50,
			"bullet_live_timer" : 2,
			"bounce_speed" : .9,
			"fire_rate" : 0.8, # per second
			"reload_time" : 2.5, # seconds
			"magazine_size" : 10, # bullets
			"accuracy" : 0.03, # try to implement some sort of random spray
			"magazine_depletion_size" : 1,
			"speed_with_gun" : 90,
			"wait_time_after_dodge_timer" : .25,
			"dodge_speed_with_gun" : 200,
			"dodge_distance_with_gun" : 200,
			"first_dodge_timer" : .5, # make this bigger than dodge_wait_time_with_gun
			"health" : 100,
			"gun_bullet" : "1_bullet",
			"magazine_max_size" : 10
	}
	
var player_2_stats = {
			"damage": 10,
			"bullet_speed": 1000,
			"bullet_slowdown" : 50,
			"bullet_live_timer" : 2,
			"bounce_speed" : .9,
			"fire_rate" : 0.8, # per second
			"reload_time" : 2.5, # seconds
			"magazine_size" : 10, # bullets
			"accuracy" : 0.03, # try to implement some sort of random spray
			"magazine_depletion_size" : 1,
			"speed_with_gun" : 90,
			"wait_time_after_dodge_timer" : .25,
			"dodge_speed_with_gun" : 200,
			"dodge_distance_with_gun" : 200,
			"first_dodge_timer" : .5, # make this bigger than dodge_wait_time_with_gun
			"health" : 100,
			"gun_bullet": "1_bullet",
			"magazine_max_size": 10
	}

var player_2_stats_defaults = {
			"damage": 10,
			"bullet_speed": 1000,
			"bullet_slowdown" : 50,
			"bullet_live_timer" : 2,
			"bounce_speed" : .9,
			"fire_rate" : 0.8, # per second
			"reload_time" : 2.5, # seconds
			"magazine_size" : 10, # bullets
			"accuracy" : 0.03, # try to implement some sort of random spray
			"magazine_depletion_size" : 1,
			"speed_with_gun" : 90,
			"wait_time_after_dodge_timer" : .25,
			"dodge_speed_with_gun" : 200,
			"dodge_distance_with_gun" : 200,
			"first_dodge_timer" : .5, # make this bigger than dodge_wait_time_with_gun
			"health" : 100,
			"gun_bullet": "1_bullet",
			"magazine_max_size": 10
	}

#func _ready():
#	return player_1_stats
#var gun_stats = {
#	gun_tag.Pistol: {
#			"damage": 10,
#			"bullet_speed": 1000,
#			"bullet_slowdown" : 50,
#			"gun_shoot_timer" : 2,
#			"bounce_speed" : .9
#	},
#
#	gun_tag.SMG:
#		{
#			"bullet_speed" : 1000,
#			"damage" : 2,
#			"bullet_slowdown" : 30,
#			"gun_shoot_timer" : 1,
#			"bounce_speed" : .9
#		},
#
#
#
#	gun_tag.Shottey:
#		{
#			"bullet_speed" : 900, #smaller because of shottey script spread
#			"damage" : 10,
#			"bullet_slowdown" : 30,
#			"gun_shoot_timer" : 3,
#			"bounce_speed" : .9
#		},
#
#
#
#	gun_tag.Sniper_boi:
#		{
#			"bullet_speed" : 3000,
#			"damage" : 50,
#			"bullet_slowdown" : 30,
#			"gun_shoot_timer" : 4,
#			"bounce_speed" : .5
#		},
#
#
#
#	gun_tag.gatling_gun:
#		{
#			"bullet_speed" : 900,
#			"damage" : 1,
#			"bullet_slowdown" : 30,
#			"gun_shoot_timer" : 2,
#			"bounce_speed" : .6
#		},
#
#
#
#
#	gun_tag.Grenade_launcher:
#		{
#			"bullet_speed" : 600, #smaller because of grenade speed
#			"damage" : 70,
#			"bullet_slowdown" : 50,
#			"gun_shoot_timer" : 2,
#			"bounce_speed" : .5
#		},
#
#
#
#		gun_tag.laser_boi:
#			{
#				"damage" : 30,
#				"ray_distance" : 500,
#				"gun_shoot_timer" : 1.5 ,
#				"bullet_slowdown" : 30
#			}
#
#
#}
#
var damage = 0
var fire_rate = 0
var reload_time = 0
var magazine_size = 0
var accuracy = 0
var bullet_speed = 0
var shotgun_bullet_spread = 0
var magazine_depletion_size = 0

var ray_distance
var charge_time

var grenade_speed = 30


var gun_shoot_timer


##Gun effects
var speed_with_gun
var dodge_speed_with_gun
var dodge_wait_time_with_gun
var dodge_distance_with_gun
var dodge_cool_down
#func _ready():
#	current_gun_tag = gun_tag.Pistol
#	perform_actions()
#
#func perform_actions():
#	match current_gun_tag:
#		gun_tag.Pistol:
#			fire_rate = 0.8 # per second
#			reload_time = 2.5 # seconds
#			magazine_size = 10 # bullets
#			accuracy = 0.03 # try to implement some sort of random spray
#			magazine_depletion_size = 1
#			speed_with_gun = 90
#			dodge_wait_time_with_gun = .25
#			dodge_speed_with_gun = 200
#			dodge_distance_with_gun = 200
#			dodge_cool_down = .5 # make this bigger than dodge_wait_time_with_gun
#
#
#		gun_tag.SMG:
#			bullet_speed = 300
#			damage = 2
#			fire_rate = 0.1 # per second
#			magazine_size = 20
#			reload_time = 3 # seconds
#			accuracy = 0.07
#			magazine_depletion_size = 1
#			speed_with_gun = 80
#			dodge_wait_time_with_gun = .5
#			dodge_speed_with_gun = 200
#			dodge_distance_with_gun = 200
#			dodge_cool_down = .75
#
#		gun_tag.Shottey:
#			bullet_speed = 300 #smaller because of shottey script spread
#			damage = 10
#			fire_rate = 1 # per second
#			magazine_size = 15
#			reload_time = 2.5 # seconds
#			accuracy = .05
#			shotgun_bullet_spread = .3 # how much the bullets shake/spread
#			magazine_depletion_size = 3
#			speed_with_gun = 70
#			dodge_wait_time_with_gun = .75
#			dodge_speed_with_gun = 200
#			dodge_distance_with_gun = 200
#			dodge_cool_down = .75
#
#		gun_tag.Sniper_boi:
#			bullet_speed = 1200
#			damage = 50
#			fire_rate = 1 # per second
#			magazine_size = 5
#			reload_time = 3 # seconds
#			accuracy = 0.01
#			magazine_depletion_size = 1
#			speed_with_gun = 60
#			dodge_wait_time_with_gun = .5
#			dodge_speed_with_gun = 200
#			dodge_distance_with_gun = 200
#			dodge_cool_down = 1.5
#
#		gun_tag.gatling_gun:
#			bullet_speed = 300
#			damage = 5
#			fire_rate = .3 # per second
#			magazine_size = 99
#			reload_time = 5 # seconds
#			accuracy = .05
#			shotgun_bullet_spread = .5 # how much the bullets shake/spread
#			magazine_depletion_size = 3
#			speed_with_gun = 50
#			dodge_wait_time_with_gun = .75
#			dodge_speed_with_gun = 100
#			dodge_distance_with_gun = 100
#			dodge_cool_down = .75
#
#
#		gun_tag.Grenade_launcher:
#			bullet_speed = 30 #smaller because of grenade speed
#			damage = 70
#			fire_rate = 1 # per second
#			magazine_size = 7
#			reload_time = 5 # seconds
#			accuracy = .05
#			magazine_depletion_size = 1
#			speed_with_gun = 70
#			dodge_wait_time_with_gun = .5
#			dodge_speed_with_gun = 200
#			dodge_distance_with_gun = 200
#			dodge_cool_down = .75
#
#		gun_tag.laser_boi:
#			bullet_speed = 30 #smaller because of grenade speed
#			damage = 70
#			fire_rate = 2 # per second ( for laser_boi, this number has to be bigger than gun_shoot_timer for it to shoot on time correctly)
#			magazine_size = 7
#			reload_time = 5 # seconds
#			accuracy = .001
#			magazine_depletion_size = 1
#			ray_distance = 500
#			gun_shoot_timer = 1.5 # (for laser_boi, this number has to be smaller than fire_rate for it to shoot on time correctly)
#			speed_with_gun = 80
#			dodge_wait_time_with_gun = .25
#			dodge_speed_with_gun = 200
#			dodge_distance_with_gun = 200
#			dodge_cool_down = .25
#
#
