extends Label

func update_score(score: int) ->void:#connected via signal
	text = "Score: " +str(score)
