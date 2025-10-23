extends CharacterBody2D

const fire_speed = 600 #pixels/s

var is_shot = false

func _ready() -> void:
	if is_shot == true:
		visible = true
	else:
		visible = false

func recieve_position(incoming_position:Vector2, incoming_rotation:float):
	if is_shot == false:
		position = incoming_position
		rotation = incoming_rotation

func _physics_process(delta: float) -> void:
	if is_shot == true:
		velocity.y = fire_speed
		velocity = velocity.rotated(rotation)
		move_and_slide()
