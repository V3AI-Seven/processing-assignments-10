extends Control
var score = 0

func increase_score() -> void:
	score += 1
	$CurrentScore.text = ("Score: "+ str(score))
	
func reset() -> void:
	score = 0
	$CurrentScore.text = ("Score: "+ str(score))
