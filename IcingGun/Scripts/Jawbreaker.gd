extends KinematicBody2D

const THROW_VELOCITY = Vector2(50,50)
const COOLDOWN = 1

var touched_something:= false

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += get_parent().GRAVITY/2 * pow(delta * 20, 2)
	var collision = move_and_collide(velocity*delta*get_parent().PIXELS_PER_METER)
	if collision != null:
		if !touched_something:
			$Timer.start()
			touched_something = true
		_on_inpact(collision.normal)
		
func launch(direction):
	velocity = THROW_VELOCITY * direction
func _on_inpact(normal):
	velocity = velocity.bounce(normal)
	velocity *= 0.8



func _on_Area2D_body_entered(body):
	if body.is_in_group("destructable"):
		body.disappear()
		queue_free()
	if body.is_in_group("enemy"):
		body.take_damage(2.5)

func _on_Timer_timeout():
	queue_free()
