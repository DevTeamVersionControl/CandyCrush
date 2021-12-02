extends StaticBody2D

var can_reappear = true
var should_reappear:= false

func disappear():
	visible = false
	set_collision_layer_bit(0, false)
	set_collision_layer_bit(1, false)
	$Timer.start()


func _on_Timer_timeout():
	if can_reappear:
		reappear()
	else:
		should_reappear = true

func reappear():
	visible = true
	set_collision_layer_bit(0, true)
	set_collision_layer_bit(1, true)
	should_reappear = false
