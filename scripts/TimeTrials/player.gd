extends CharacterBody3D

const mouse_sensitivity = 0.002
const sprint_speed = 25 # running speawaasdawdsawded
const move_speed = 20 #not running speed 
const jump_velocity = 100


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)

		$CameraAnchor/Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraAnchor/Camera3D.rotation.x = clampf($CameraAnchor/Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func _physics_process(delta: float) -> void:
	var target_velocity = Vector3.ZERO
	var world_target_velocity = Vector3.ZERO
	var applied_speed = move_speed
	
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y += jump_velocity
	
	if Input.is_key_pressed(KEY_SHIFT):
		applied_speed = sprint_speed
	
	if Input.is_key_pressed(KEY_W):
		target_velocity.z -= applied_speed
	if Input.is_key_pressed(KEY_S):
		target_velocity.z += applied_speed
	if Input.is_key_pressed(KEY_A):
		target_velocity.x -= applied_speed
	if Input.is_key_pressed(KEY_D):
		target_velocity.x += applied_speed
	
	world_target_velocity = target_velocity.rotated(Vector3.UP, rotation.y)
	velocity.x = world_target_velocity.x
	velocity.z = world_target_velocity.z
	
	velocity += get_gravity()
	move_and_slide()
