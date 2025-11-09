extends CharacterBody2D

#Name:Grayson
#Date: Oct 24, 2025
#Course: Grade 10 Intro to Computers and stuff
#Project Description: Goal is to have a player move around and shoot asteroids(boulders). 


const roll_speed = 5 #rad/s
const move_speed = 350 #pixels/s

signal position_updated(outgoing_position:Vector2, outgoing_rotation: float)
signal fire_shot()
signal game_end(score)
signal blur_on() #enables a blur to make text on top more visible

var game_running = false
var can_move = true

var score = 0

func update_current_score(current_score:int) -> void:#linked with signal
	score = current_score

func start_game() -> void:#linked with signal
	game_running = true

func hit_boulder(hit_position:Vector2) -> void:#connected with signal
	can_move = false
	game_end.emit(score)
	blur_on.emit()

func _physics_process(delta: float) -> void:#runs at a fixed rate, and delta is time between ticks(updates)
	
	if can_move == true: #used to disable player control
		#bullet shooting
		if Input.is_key_pressed(KEY_SPACE):
			if $FireCooldown.is_stopped():
				$FireCooldown.start()
				fire_shot.emit()
		
		var mouse_pos = get_viewport().get_mouse_position()
		look_at(mouse_pos)
		rotation_degrees += 90
		
		#movement
		var target_velocity = Vector2.ZERO
		if Input.is_key_pressed(KEY_W):
			target_velocity.y += -move_speed
		if Input.is_key_pressed(KEY_S):
			target_velocity.y += move_speed
		if Input.is_key_pressed(KEY_A):
			target_velocity.x += -move_speed
		if Input.is_key_pressed(KEY_D):
			target_velocity.x += move_speed
		target_velocity = target_velocity.rotated(rotation)
		
		velocity = target_velocity

		move_and_slide()
		position_updated.emit(position,rotation)
