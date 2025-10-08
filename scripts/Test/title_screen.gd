extends Control
signal start_test

func start() -> void:
	start_test.emit()
	visible = false
