extends Control

func generate_question(title:String, answers:Array, correct_answer:int, question_index:int) -> void:
	var buttons = $AnswerButtons
	
	var answer1 = $AnswerButtons/AnswerButtonsTop/Answer1
	var answer2 = $AnswerButtons/AnswerButtonsTop/Answer2
	var answer3 = $AnswerButtons/AnswerButtonsBottom/Answer3
	var answer4 = $AnswerButtons/AnswerButtonsBottom/Answer4
	
	print("Generating question")
	
	buttons.visible = false
	Utilities.delay(2)
	
	answer1.text = answers[0]
	answer2.text = answers[1]
	answer3.text = answers[2]
	answer4.text = answers[3]
	buttons.visible = true

func start() -> void:
	print("Starting quiz")
	generate_question("2+2?", ["22","2","fish","4"], 3,1)
