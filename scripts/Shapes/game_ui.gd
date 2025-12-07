extends Control
signal start_game

func start() -> void: #linked via signal
	$StartUI.visible = false
	ShapesGlobal.attempts += 1 # a global to track attempts
	start_game.emit() #connects to many timers to start the animations

func game_over() -> void: #linked via signal
	$LoseAnim/AnimationPlayer.play("LoseAnimation")
 
func restart_game() -> void: #linked via signal
	get_tree().change_scene_to_file("res://scenes/projects/shapes_dodge.tscn") #reloads the scene

func game_win() -> void: #linked with signal
	$WinAnim/AnimationPlayer.play("WinAnimation")
	$WinAnim/AttemptCounter.text = "Total attempts: " + str(ShapesGlobal.attempts)
