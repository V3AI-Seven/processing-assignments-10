extends AnimationPlayer
const animation_delay = 0.2 # seconds

func game_end(score) -> void:#connected with signal
	await get_tree().create_timer(animation_delay).timeout #magic line that is basically python's time.sleep() 
	get_animation("ScoreToCentre").track_set_key_value(2,1,"Game Over\nScore: " + str(score))#updates text in animation to reflect score
	play("ScoreToCentre")#plays animation

func point_scored(_score) -> void:#connected via signal
	play("ScoreShake")#plays animation
