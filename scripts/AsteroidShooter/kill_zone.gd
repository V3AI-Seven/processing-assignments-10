extends Area2D

func object_entered(object) -> void:
	if (object.has_meta("is_shot") and object.get_meta("is_shot") == true) or (object.has_meta("is_in_play") and object.get_meta("is_in_play") == true):
		#first condition checks if it's a bullet, second checks if it's a boulder
		print("[Asteroid] Object " + str(object) + "has hit the kill zone, killing")
		object.queue_free()
		
