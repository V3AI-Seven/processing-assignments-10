extends Control

var project_index:int

func switch_to_project() -> void:
	project_index = $ProjectSelector.selected
	match project_index:
		-1:
			pass
		0: #Clicker game
			get_tree().change_scene_to_file("res://scenes/projects/clicker_game.tscn")
