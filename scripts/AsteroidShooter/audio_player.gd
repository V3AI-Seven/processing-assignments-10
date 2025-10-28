extends Node2D

func play_shoot_sound() -> void: #connected via signal
	$Shoot.play()

func play_boulder_destroy_sound(_scored) -> void:#connected via signal
	$BoulderDestroy.play()

func play_game_over(_score) -> void:#connected via signal
	$GameOver.play()
	$VolumeFader.play("BackgroundMusicFadeOut")

func start_background_music() -> void:
	$BackgroundMusic.play()
