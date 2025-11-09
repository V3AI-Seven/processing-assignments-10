extends Area3D
signal game_finish()

func object_entered(object:Node3D) -> void:
	if object != null and object.get_meta("IsPlayer",false):
		game_finish.emit()
