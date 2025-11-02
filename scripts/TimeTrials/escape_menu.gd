extends Control
signal resume_game

func resume_game_button() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	resume_game.emit()
