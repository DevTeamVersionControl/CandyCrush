extends Node2D

const COOLDOWN = 1
const SLOWDOWN = 0.5
const ICING = preload("res://Scenes/Icing.tscn")

var locked:= false


func _process(_delta):
	if Input.is_action_pressed("shoot"):
		shoot()
		locked = true
	else:
		locked = false

func launch(direction):
	if direction.x > 0:
		rotation = direction.angle() - PI/16
	else:
		rotation = direction.angle() + PI/16

func shoot():
	var drop = ICING.instance()
	get_tree().current_scene.add_child(drop)
	drop.global_position = global_position
	drop.launch(rotation + rand_range(-PI/24, PI/24))
	
func get_slowdown():
	return SLOWDOWN
