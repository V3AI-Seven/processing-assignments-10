extends Area3D

signal reset_game()

func player_entered(object:Node3D) -> void:
	if object != null and object.get_meta("IsPlayer",false) == true:
		reset_game.emit()
