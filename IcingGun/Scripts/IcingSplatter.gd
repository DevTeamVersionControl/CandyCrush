extends Area2D

const slowdown_ratio = 0.5

func _on_Area2D_body_entered(body):
	if body.is_in_group("Actor"):
		if body.slowdown == 1:
			body.slowdown *= slowdown_ratio
		elif body.slowdown > slowdown_ratio:
			body.slowdown *= slowdown_ratio


func _on_Area2D_body_exited(body):
	if body.is_in_group("Actor"):
		body.slowdown /= slowdown_ratio
