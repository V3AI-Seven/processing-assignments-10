extends Label
var score = 0

signal score_to_player(total_score:int)

func score_updated(scored:int): #linked with signal
	score += scored
	text = "Score: " +str(score)
	score_to_player.emit(score)
