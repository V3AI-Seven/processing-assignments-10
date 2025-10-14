extends Control

signal score_change(new_score: int)
signal quiz_finish(score:int)

var current_question = 0
var current_correct_button = -1
var score = 0
var buttons

func _ready() -> void:
	buttons = $AnswerButtons

func generate_question(title:String, answers:Array, correct_answer:int) -> void:
	
	
	var answer1 = $AnswerButtons/AnswerButtonsTop/Answer1
	var answer2 = $AnswerButtons/AnswerButtonsTop/Answer2
	var answer3 = $AnswerButtons/AnswerButtonsBottom/Answer3
	var answer4 = $AnswerButtons/AnswerButtonsBottom/Answer4
	
	var titleText = $QuestionTitle
	
	print("Generating question")
	
	buttons.visible = false
	visible = false
	Utilities.delay(1)
	
	answer1.text = answers[0]
	answer2.text = answers[1]
	answer3.text = answers[2]
	answer4.text = answers[3]
	
	titleText.text = title
	
	current_correct_button = correct_answer
	
	buttons.visible = true
	visible = true
	print("Questions Visible")


func start() -> void:
	print("Starting quiz")
	current_question = 1
	generate_question("2+2?", ["22","2","fish","4"], 3) #Simple math question


func next_question() -> void:
	current_question += 1
	
	match current_question:
		2:
			generate_question("Yes, no, maybe, so",["Yes","No","Maybe","So"], 4) #Annoying question
		3:
			generate_question("What is the answer to Life, The Universe, and Everything?", ["No", "42", "24", "Everything"],2) #Question about a great book
		4:
			generate_question("What was this game made with?",["Unity","Godot","Python","Unreal"],2)
		5:
			visible = false
			quiz_finish.emit(score)

func question_correct() -> void:
	score += 1
	print("Question Correct!")
	print("New score: "+str(score))
	
	score_change.emit(score)
	buttons.visible = false
	visible = false
	$Success.play()

func question_incorrect() -> void:
	print("Question Incorrect!")

	buttons.visible = false
	visible = false
	$Failure.play()


#Yes this is quite redundant, and could be replaced with more functions, but it was fast and it is easy to runderstand from a readerr's perspectives
#All of these are connected with signals(a way of linking events). if you open in the Godot editor, you can see the connections
func answer_1() -> void:
	if current_correct_button == 1:
		#$AnimationPlayer.play("FadeInCorrect")
		question_correct()
		next_question()
	else:
		#$AnimationPlayer.play("FadeInIncorrect")
		question_incorrect()
		next_question()
		
func answer_2() -> void:
	if current_correct_button == 2:
		#$AnimationPlayer.play("FadeInCorrect")
		question_correct()
		next_question()
	else:
		#$AnimationPlayer.play("FadeInIncorrect")
		question_incorrect()
		next_question()
		
func answer_3() -> void:
	if current_correct_button == 3:
		#$AnimationPlayer.play("FadeInCorrect")
		question_correct()
		next_question()
	else:
		#$AnimationPlayer.play("FadeInIncorrect")
		question_incorrect()
		next_question()
			
func answer_4() -> void:
	if current_correct_button == 4:
		#$AnimationPlayer.play("FadeInCorrect")
		question_correct()
		next_question()
	else:
		#$AnimationPlayer.play("FadeInIncorrect")
		question_incorrect()
		next_question()
