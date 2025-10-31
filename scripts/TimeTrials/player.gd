extends CharacterBody3D

@export var debug:bool = true

const mouse_sensitivity = 0.002

const sprint_acceleration = 2.5 # running acceleration in m/s
const max_sprint_speed = 9 # in m/s
const air_sprint_speed = 1.5 # speed in m/s

const jump_velocity = 8 #no clue what this is measured in or why this seems good
const gravity = 15 #in m/s

var target_velocity = Vector3.ZERO
var world_target_velocity = Vector3.ZERO

var velocity_increase = Vector3.ZERO
var single_velocity_multiplier = 1 #multiplier to increase velocity


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if debug == true:
		$CameraAnchor/Camera3D/Debug.visible = true
	else:
		$CameraAnchor/Camera3D/Debug.visible = false

func _input(event): #called on inputs(mouse movements and keypressed)
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		$CameraAnchor/Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraAnchor/Camera3D.rotation.x = clampf($CameraAnchor/Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))


func update_velocity_feed() -> void: #updates a debug feed for velocities
	#actual velocities
	var velX = snapped(velocity.x,0.1)
	var velY = snapped(velocity.y,0.1)
	var velZ = snapped(velocity.z,0.1)
	$CameraAnchor/Camera3D/Debug/VelocityDebug.text = "VelX:"+str(velX)+" VelY:"+str(velY)+" VelZ:"+str(velZ)
	
	#target velocities
	var target_velX = snapped(target_velocity.x,0.1)
	var target_velY = snapped(target_velocity.y,0.1)
	var target_velZ = snapped(target_velocity.z,0.1)
	$CameraAnchor/Camera3D/Debug/TargetVelocityDebug.text = "TVelX:"+str(target_velX)+" TVelY:"+str(target_velY)+" TVelZ:"+str(target_velZ)


func add_velocity(added_velocity:Vector3) -> void: #function to be called by other things, to add or remove velocity
	print("[Runner] Velocity increase called, increasing by "+str(added_velocity)+" at the end of the current physics frame")
	velocity_increase = added_velocity

func multiply_all_velocity(multiplier:float) -> void: #function to be called by other things and here, to mutliply velocity
	print("[Runner] Velocity multiplier called, multiplying by "+str(multiplier)+" at the end of the current physics frame")
	single_velocity_multiplier = multiplier


func _physics_process(delta: float) -> void: #runs at a fixed rate, useful for physics based things like movement, you then multiply by delta, which is the time between ticks(updates)
	
	var target_acceleration = Vector3.ZERO
	var applied_acceleration = sprint_acceleration #speed that is applied to the player when they are moving
	
	#gravity handling
	if target_velocity.y > -gravity and not is_on_floor():
		target_velocity.y -= gravity * delta
	elif is_on_floor():
		target_velocity.y = 0
	
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor(): #jumping
		target_velocity.y += jump_velocity
		multiply_all_velocity(1.2)
	
	if not is_on_floor(): #mid air movement
		applied_acceleration = 2 #m/s
	
	#movement
	if Input.is_key_pressed(KEY_W):
		target_acceleration.z -= applied_acceleration
	if Input.is_key_pressed(KEY_S):
		target_acceleration.z += applied_acceleration
	if Input.is_key_pressed(KEY_A):
		target_acceleration.x -= applied_acceleration
	if Input.is_key_pressed(KEY_D):
		target_acceleration.x += applied_acceleration
	
	target_acceleration = target_acceleration.rotated(Vector3.UP,rotation.y) # TODO: this is wrong, needs fixing to rotate properly
	#z axis movement application, caps running speed to not add speed if we are more than the max speed
	if abs(target_velocity.z) < max_sprint_speed or sign(target_acceleration.z) != sign(target_velocity.z):
		target_velocity.z += target_acceleration.z
	
	#x axis movement application, caps running speed to not add speed if we are more than the max speed
	if abs(target_velocity.x) < max_sprint_speed or sign(target_acceleration.x) != sign(target_velocity.x):
		target_velocity.x += target_acceleration.x
	
	
	#natural deceleration when not moving
	if not (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_S)) and is_on_floor():
		target_velocity.z = lerpf(target_velocity.z,0,0.5)
	if not (Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_D)) and is_on_floor():
		target_velocity.x = lerpf(target_velocity.x,0,0.5)
	
	
	if single_velocity_multiplier != 1: #adds velocity mutliplier
		target_velocity *= single_velocity_multiplier
		print("[Runner] New velocity will be "+str(target_velocity))
		single_velocity_multiplier = 1
	
	if velocity_increase != Vector3.ZERO: #adds velocity
		target_velocity += velocity_increase
		velocity_increase = Vector3.ZERO
		
	velocity = target_velocity
	#velocity = velocity.rotated(Vector3.UP,rotation.y)
	
	update_velocity_feed()
	move_and_slide()
