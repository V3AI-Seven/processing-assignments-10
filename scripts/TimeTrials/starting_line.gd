extends Node3D
var game_started:bool = false

signal game_start()

func start_game(object:Node3D) -> void: #linked with signal to area
	if object.has_meta("IsPlayer") and object.get_meta("IsPlayer") == true and game_started == false:
		print("[Runner] Game started")
		game_started = true
		game_start.emit()

func reset_game() -> void:#linked with signal
	game_started = false
