extends Control
var current_question

#signal new_question(title:String, answers:Array, correct_answer:int, question_index:int)

func next_question() -> void:
	current_question += 1
	match current_question:
		2:
			pass



func start_test() -> void:
	#new_question.emit("2+2?", ["22","2","fish","4"], 3,1) #Simple math question
	pass
