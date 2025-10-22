extends Control

signal score_change(new_score: int)
signal quiz_finish(score:int)

var current_question = 0
var current_correct_button = -1
var score = 0
var buttons

func _ready() -> void: #Auto run on start of scene
	visible = false
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
	print("[Quiz] Questions Visible")


func start() -> void:
	print("[Quiz] Starting quiz")
	current_question = 1
	generate_question("2+2?", ["22","2","fish","4"], 3) #Simple math question


func next_question() -> void:
	current_question += 1
	
	match current_question:
		2:
			generate_question("Yes, no, maybe, so?",["Yes","No","Maybe","So"], 4) #Annoying question
		3:
			generate_question("What is the answer to Life, The Universe, and Everything?", ["No", "42", "24", "Everything"],2) #Question about a great book
		4:
			generate_question("What was this game made with?",["Unity","Godot","Python","Unreal"],2)
		5:
			generate_question("Something has changed about the sun. How long is the delay for us to know?",["Instantly", "25 seconds","8 minutes", "4 hours"],3)
		6:
			generate_question("Including the 3 at the start, what is the 27th number of Pi? Excluding rounding.",["8","3","7","4"],1)
		7:
			generate_question("What is the name of the standard English keyboard layout?",["Homerow","FGHJ","QWERTY","Linear"],3)
			
		8:
			visible = false
			quiz_finish.emit(score)

func question_correct() -> void:
	score += 1
	print("[Quiz] Question Correct!")
	print("[Quiz] New score: "+str(score))
	
	score_change.emit(score)
	buttons.visible = false
	visible = false
	$Success.play()

func question_incorrect() -> void:
	print("[Quiz] Question Incorrect!")

	buttons.visible = false
	visible = false
	$Failure.play()


#Yes this is quite redundant, and could be replaced with more functions, but it was fast and it is easy to runderstand from a readerr's perspectives
#All of these are connected with signals(a way of linking events). if you open in the Godot editor, you can see the connections
func answer_1() -> void:#connected via signal
	if current_correct_button == 1:
		#$AnimationPlayer.play("FadeInCorrect")
		question_correct()
		next_question()
	else:
		#$AnimationPlayer.play("FadeInIncorrect")
		question_incorrect()
		next_question()
		
func answer_2() -> void:#connected via signal
	if current_correct_button == 2:
		#$AnimationPlayer.play("FadeInCorrect")
		question_correct()
		next_question()
	else:
		#$AnimationPlayer.play("FadeInIncorrect")
		question_incorrect()
		next_question()
		
func answer_3() -> void:#connected via signal
	if current_correct_button == 3:
		#$AnimationPlayer.play("FadeInCorrect")
		question_correct()
		next_question()
	else:
		#$AnimationPlayer.play("FadeInIncorrect")
		question_incorrect()
		next_question()
			
func answer_4() -> void:#connected via signal
	if current_correct_button == 4:
		#$AnimationPlayer.play("FadeInCorrect")
		question_correct()
		next_question()
	else:
		#$AnimationPlayer.play("FadeInIncorrect")
		question_incorrect()
		next_question()
