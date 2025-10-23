extends CharacterBody2D

const roll_speed = 5 #rad/s
const move_speed = 350 #pixels/s

signal position_updated(outgoing_position:Vector2, outgoing_rotation: float)
signal fire_shot()


func _physics_process(delta: float) -> void:#runs at a fixed rate, and delta is time between ticks(updates)
	
	#bullet shooting
	if Input.is_key_pressed(KEY_SPACE):
		if $FireCooldown.is_stopped():
			$FireCooldown.start()
			#print("[Asteroid] Shooting bullet")
			fire_shot.emit()
	
	#roll control
	var target_roll = 0
	if Input.is_key_pressed(KEY_A):
		target_roll += -roll_speed * delta
	if Input.is_key_pressed(KEY_D):
		target_roll += roll_speed * delta
	rotate(target_roll)
	
	#movement
	var target_velocity = Vector2.ZERO
	if Input.is_key_pressed(KEY_W):
		target_velocity.y += -move_speed
	if Input.is_key_pressed(KEY_S):
		target_velocity.y += move_speed
	
	#print("[Asteroid] target velocity = "+str(target_velocity.y))
	target_velocity = target_velocity.rotated(rotation)
	
	velocity = target_velocity
	#print("[Asteroid] velocity = "+str(velocity.y))
	move_and_slide()
	position_updated.emit(position,rotation)
