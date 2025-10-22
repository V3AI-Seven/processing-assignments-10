extends Sprite2D
var clicks = 0

func pig_clicked() -> void:
	clicks += 1
	print("[Pig Clicker] Current clicks: " + str(clicks))

func cow_clicked() -> void:
	clicks += 2
	print("[Pig Clicker] Current clicks: " + str(clicks))

func chick_clicked() -> void:
	clicks += 3
	print("[Pig Clicker] Current clicks: " + str(clicks))
