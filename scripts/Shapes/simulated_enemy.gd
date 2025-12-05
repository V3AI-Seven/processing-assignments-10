extends Node2D

func start_game() -> void:
	$TriggerTimer.start()

func end_game() -> void:
	$TriggerTimer.stop()

func start_particles() -> void:
	$GPUParticles2D.emitting = true
