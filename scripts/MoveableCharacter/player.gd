extends CharacterBody2D

var move_enabled = false

func move_allowed() -> void:
	move_enabled = true
	
func _input(event: InputEvent) -> void:
	pass
