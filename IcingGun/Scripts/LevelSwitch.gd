extends Area2D

export var next_level:PackedScene


func _on_LevelSwitch_body_entered(body):
	if body.is_in_group("player"):
		if get_tree().change_scene_to(next_level):
			print("Error loading scene")
