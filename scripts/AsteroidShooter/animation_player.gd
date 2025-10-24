extends AnimationPlayer
const animation_delay = 0.2# seconds

func game_end() -> void:#connected with signal
	await get_tree().create_timer(animation_delay).timeout #magic line that is basically python's time.sleep() 
	play("ScoreToCentre")
