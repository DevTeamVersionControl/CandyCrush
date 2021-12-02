extends Node2D

const PIXELS_PER_METER = 16
const UP = Vector2(0,-1)
const GRAVITY = 9.8

var screen_size

var mob = preload("res://Scenes/Enemy.tscn")


func _ready():
	screen_size = get_viewport_rect().size

func _on_MobTimer_timeout():
	var new_mob = mob.instance()
	add_child(new_mob)
	new_mob.global_position = $Position2D.global_position
	new_mob.target = $Player
