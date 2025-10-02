extends Node2D

signal move_allowed
func enable_movement() -> void:
	move_allowed.emit()
	$Start.visible = false
