extends CharacterBody2D

# Name: Grayson
# Date: December 1-8
# Project: Shapes Dodge
# Description: Its a game where you have to dodge shapes trying to hit you.

var can_move := true

const SPEED := 300.0 # in pixels/s

signal game_over

func player_hit() -> void: #linked via signal
	can_move = false
	$GPUParticles2D.emitting = true
	game_over.emit() #signal that activates the end screen, and stops all of the timers


func _physics_process(_delta: float) -> void: #runs every "physics frame"(a fixed speed that is useful for things like movement)
	
	velocity = Vector2.ZERO
	
	if can_move:
		if Input.is_key_pressed(KEY_W):
			velocity.y -= SPEED
		if Input.is_key_pressed(KEY_S):
			velocity.y += SPEED
		if Input.is_key_pressed(KEY_A):
			velocity.x -= SPEED
		if Input.is_key_pressed(KEY_D):
			velocity.x += SPEED
	
	move_and_slide() #inbuilt function to handle movement and collions using the inbuilt velocity variable
	
