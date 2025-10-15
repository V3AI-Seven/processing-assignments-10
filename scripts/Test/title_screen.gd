extends Control
signal start_test

func start() -> void:#connected via signal
	start_test.emit()
	visible = false
