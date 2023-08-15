extends Node2D

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
			"magazine_max_size" : 10,
			"max_health" : 100,
			"grenade_num" : 1,
			"grenade_max_num" : 1,
			"grenade_speed" : 800,
			"grenade_slowdown" : 400,
			"bullet_bounce_num" : 3,
			
			"vampire_bullets" : false, #should start false
			"ghost_bullets" : false, #should start false
			"grenade_bullets" : true
	}
	
var player_1_stats_defaults = {
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
			"magazine_max_size" : 10,
			"max_health" : 100,
			"grenade_num" : 1,
			"grenade_max_num" : 1,
			"grenade_speed" : 800,
			"grenade_slowdown" : 400,
			"bullet_bounce_num" : 3,
			
			"vampire_bullets" : false, #should start false
			"ghost_bullets" : false,
			"grenade_bullets" : false
	}
	
var player_2_stats = {
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
			"magazine_max_size" : 10,
			"max_health" : 100,
			"grenade_num" : 1,
			"grenade_max_num" : 1,
			"grenade_speed" : 800,
			"grenade_slowdown" : 400,
			"bullet_bounce_num" : 3,
			
			"vampire_bullets" : false, #should start false
			"ghost_bullets" : false,
			"grenade_bullets" : false
	}

var player_2_stats_defaults = {
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
			"magazine_max_size" : 10,
			"max_health" : 100,
			"grenade_num" : 1,
			"grenade_max_num" : 1,
			"grenade_speed" : 800,
			"grenade_slowdown" : 400,
			"bullet_bounce_num" : 3,
			
			"vampire_bullets" : false, #should start false
			"ghost_bullets" : false,
			"grenade_bullets" : false
	}


