extends Label
var score = 0

func score_updated(scored:int): #linked with signal
	score += scored
	text = "Score: " +str(score)
