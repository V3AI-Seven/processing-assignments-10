extends Control
var current_question

func next_question() -> void:
	current_question += 1
	match current_question:
		2:
			pass

func generate_question(title:String, answers:Array, correct_answer:int, question_index:int) -> void:
	current_question = question_index

func start_test() -> void:
	generate_question("2+2?", ["22","2","fish","4"], 3,1) #Simple math question
