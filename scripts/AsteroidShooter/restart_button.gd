extends Button

func _pressed() -> void: #called when button pressed
	get_tree().change_scene_to_file("res://scenes/projects/asteroid_shooter.tscn")

func enable_visibility(_score) -> void: #connected with signal
	visible = true
