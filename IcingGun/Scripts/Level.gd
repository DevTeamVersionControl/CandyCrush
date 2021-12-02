extends Node2D

const PIXELS_PER_METER = 16
const UP = Vector2(0,-1)
const GRAVITY = 9.8

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
