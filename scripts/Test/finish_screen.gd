extends Control

func play_again() -> void: #connected via signal
	visible = false
	get_tree().change_scene_to_file("res://scenes/projects/test.tscn")

#logic for end of game
func show_finsh(score:int) -> void: #connected via signal
	$Score.text = "Score: " + str(score)
	visible = true
