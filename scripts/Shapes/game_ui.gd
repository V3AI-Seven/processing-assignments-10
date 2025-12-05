extends Control
signal start_game




func start() -> void: #linked via signal
	$StartUI.visible = false
	start_game.emit()

func game_over() -> void: #linked via signal
	$LoseAnim/AnimationPlayer.play("LoseAnimation")

func restart_game() -> void: #linked via signal
	get_tree().change_scene_to_file("res://scenes/projects/shapes_dodge.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
