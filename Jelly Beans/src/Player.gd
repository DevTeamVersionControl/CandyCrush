#https://www.youtube.com/watch?v=p6OQ7XVsiKw
extends KinematicBody2D

const PIXELS_PER_METER = 16
const UP = Vector2(0,-1)
const GRAVITY = 9.8
const MAX_FALL_SPEED = 12.5
const MAX_SPEED = 7
const JUMP_FORCE = 50
const ACCEL = 1.25
var facing = Vector2()
var bullet_direction = Vector2()
var jawbreaker = preload("res://Scenes/Jawbreaker.tscn")
var can_shoot = true
var screen_size

var motion = Vector2()

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(_delta):
	
	if(Input.is_action_just_pressed("shoot")):
		shoot(jawbreaker)

	
	motion.y += GRAVITY
	
	if (Input.is_action_pressed("up")):
		bullet_direction.y = -1
	elif (Input.is_action_pressed("down")):
		bullet_direction.y = 1
	else:
		bullet_direction.y = 0
	
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
	if (Input.is_action_pressed("right")):
		motion.x += ACCEL
		facing.x = 1
	elif (Input.is_action_pressed("left")):
		motion.x -= ACCEL
		facing.x = -1
	else:
		motion.x = lerp(motion.x, 0, 0.2)
	
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
	if is_on_floor():
		if (Input.is_action_just_pressed("jump")):
			motion.y = -JUMP_FORCE
	
	motion = move_and_slide(motion * PIXELS_PER_METER,UP)
	motion /= PIXELS_PER_METER
	
	if bullet_direction.y != 0:
		bullet_direction.x = 0
	else:
		bullet_direction.x = facing.x
		bullet_direction.y = -0.4
	
	if global_position.y > screen_size.y:
		get_tree().reload_current_scene()

func shoot(ammo):
	if can_shoot:
		var bullet = ammo.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.global_transform = global_transform
		bullet.launch(bullet_direction)
		motion += Vector2(-150,-60) * bullet_direction
		can_shoot = false
		$AmmoTimer.start(bullet.COOLDOWN)


func _on_AmmoTimer_timeout():
	can_shoot = true


func _on_Area2D_body_entered(body):
	if body.is_in_group("destructable"):
		body.can_reappear = false
	if body.is_in_group("enemy"):
		print("ouch")


func _on_Area2D_body_exited(body):
	if body.is_in_group("destructable"):
		body.can_reappear = true
		if body.should_reappear:
			body.reappear()