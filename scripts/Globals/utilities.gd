extends Node

func delay(time: int) -> void:
	await get_tree().create_timer(time).timeout
