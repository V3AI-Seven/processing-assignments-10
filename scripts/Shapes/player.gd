extends CharacterBody2D

var can_move := true

const SPEED := 300.0
const JUMP_VELOCITY := -400.0

signal test_animation

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_T and not event.is_echo() and event.is_pressed():
			test_animation.emit()

func player_hit() -> void:
	can_move = false


func _physics_process(_delta: float) -> void:
	
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
	
