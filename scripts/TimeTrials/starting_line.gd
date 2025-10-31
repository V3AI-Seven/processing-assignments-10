extends Node3D

signal game_start()

func start_game(object:Node3D) -> void: #linked with signal to area
	if object.has_meta("IsPlayer") and object.get_meta("IsPlayer") == true:
		print("clock started")
		game_start.emit()
