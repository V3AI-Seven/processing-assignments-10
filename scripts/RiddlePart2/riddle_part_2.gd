extends Control

var answers = ["42", "London", "Fondue Turkey Monkey"]


func check_solved() -> void:
	if $Answer1.text == answers[0] and $Answer2.text == answers[1] and $Answer3.text == answers[2]:
		$PopupPanel.popup()
