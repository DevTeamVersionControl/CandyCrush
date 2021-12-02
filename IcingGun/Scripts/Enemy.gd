extends RigidBody2D

const PIXELS_PER_METER = 16

var motion = Vector2()
var target
var is_on_floor:bool
export var speed = 5
export var jump_height = 3
export var hp = 10

func pulse():
	$Sprite.frame = 0
	motion = target.global_position - global_position
	motion.x = motion.normalized().x * speed
	motion.y = -jump_height
	linear_velocity = motion * PIXELS_PER_METER
	if (global_position.y > get_parent().screen_size.y || global_position.x > get_parent().screen_size.x || global_position.x < 0):
		queue_free()
	
func take_damage(damage):
	hp -= damage
	$Sprite.frame = 1
	if hp <= 0:
		queue_free()
