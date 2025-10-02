extends CharacterBody2D

var move_enabled = false

const speed = 500

func move_allowed() -> void:
	move_enabled = true
	
func _input(event: InputEvent) -> void:
	#I would use physics processing for this, as it is faster and related to game physiscs, but you said to use direct input mapping 
	if event is InputEventKey:
		var target_velocity = Vector2.ZERO
		if move_enabled:
			if event.keycode == KEY_W:
				print("Moving up")
				target_velocity.y += -speed
			if event.keycode == KEY_S:
				target_velocity.y += speed
			if event.keycode == KEY_A:
				target_velocity.x += -speed
			if event.keycode == KEY_D:
				target_velocity.x += speed
			
			velocity = target_velocity
			move_and_slide()
			
		else:
			pass
			#target_velocity.x = 0
			#target_velocity.y = 0
			#velocity = target_velocity
			#move_and_slide()
