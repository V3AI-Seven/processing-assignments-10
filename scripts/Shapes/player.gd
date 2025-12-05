extends CharacterBody2D

# Name: Grayson
# Date: December 1-5
# Project: Shapes Dodge
# Description: Its a game where you have to dodge shapes trying to hit you.

var can_move := true

const SPEED := 300.0
const JUMP_VELOCITY := -400.0

signal test_animation
signal game_over

func _input(event: InputEvent) -> void: #runs anytime an input is recieved (keypress, mouse click, mouse movement, and similar)
	if event is InputEventKey:
		if event.keycode == KEY_T and not event.is_echo() and event.is_pressed():
			test_animation.emit()

func player_hit() -> void: #linked via signal
	can_move = false
	$GPUParticles2D.emitting = true
	game_over.emit()


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
	
	move_and_slide()
	
