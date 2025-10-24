extends Button
signal blur_off()

func _pressed() -> void: #built in function to button, triggered when pressed
	visible = false
	blur_off.emit()
