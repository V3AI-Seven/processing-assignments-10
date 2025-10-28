extends CharacterBody3D

const mouse_sensitivity = 0.002

const sprint_speed = 25 # running speed
const move_speed = 20 #not running speed

const air_sprint_speed = 25 # running speed
const air_move_speed = 20 #not running speed

const jump_velocity = 10
const gravity = 10 #in m/s

var target_velocity = Vector3.ZERO
var world_target_velocity = Vector3.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)

		$CameraAnchor/Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraAnchor/Camera3D.rotation.x = clampf($CameraAnchor/Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func _physics_process(delta: float) -> void:
	var applied_speed = move_speed
	target_velocity = Vector3.ZERO
	world_target_velocity = Vector3.ZERO
	
	
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor(): #jumpinh
		velocity.y += jump_velocity
	
	if Input.is_key_pressed(KEY_SHIFT): #sprinting
		applied_speed = sprint_speed
	
	if not is_on_floor():
		applied_speed = 2 #m/s
	
	if Input.is_key_pressed(KEY_W):
		target_velocity.z -= applied_speed
	if Input.is_key_pressed(KEY_S):
		target_velocity.z += applied_speed
	if Input.is_key_pressed(KEY_A):
		target_velocity.x -= applied_speed
	if Input.is_key_pressed(KEY_D):
		target_velocity.x += applied_speed
	
	
	world_target_velocity += target_velocity.rotated(Vector3.UP, rotation.y)
	
	#nice, smooth stop
	if not (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_D)):
		if is_on_floor():
			world_target_velocity.x = lerpf(target_velocity.x,0,0.5)
			world_target_velocity.y = lerpf(target_velocity.y,0,0.5)
			
	velocity.x = world_target_velocity.x
	velocity.z = world_target_velocity.z
	
	velocity.y -= gravity * delta
	move_and_slide()
