extends CharacterBody3D

@export var debug = true

const mouse_sensitivity = 0.002

const sprint_acceleration = 2.5 # running acceleration in m/s
const max_sprint_speed = 9 # in m/s
const air_sprint_speed = 1.5 # speed in m/s

const jump_velocity = 8 #no clue what this is measured in or why this seems good
const terminal_fall_velocity = 25 #in m/s 

var target_velocity = Vector3.ZERO
var world_target_velocity = Vector3.ZERO

var velocity_increase = Vector3.ZERO
var single_velocity_multiplier = 1 #multiplier to increase velocity

var game_running:bool = false
var timer_running:bool = false
var timer:float = 0

var should_jump:bool = false #variable that is true when the player should jump on the next physics tick

func reset_game() -> void:#linked via signal
	timer_running = false
	timer = 0
	
	var timer_text = "00:00:000"
	$CameraAnchor/Camera3D/GameUI/Timer.text = timer_text
	
	position.x = 0
	position.y = 2
	position.z = 0
	
	rotation.y = 0
	$CameraAnchor.rotation.x = 0
	
	velocity = Vector3.ZERO
	target_velocity = Vector3.ZERO

func start_game() -> void:#linked with signal
	timer_running = true
func unpause_game() -> void:#linked with signal
	game_running = true

func _ready() -> void:
	game_running = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if debug == true:
		$CameraAnchor/Camera3D/DebugUI.visible = true
	else:
		$CameraAnchor/Camera3D/DebugUI.visible = false

func _process(delta: float) -> void:
	if timer_running and game_running:
		timer += delta
	
		var total_ms = int(timer * 1000.0)
		@warning_ignore("integer_division")
		var minutes = (total_ms / 1000) / 60
		@warning_ignore("integer_division")
		var seconds = (total_ms / 1000) % 60
		var milliseconds = total_ms % 1000 

		var timer_text = "%02d:%02d:%03d" % [minutes, seconds, milliseconds]
		$CameraAnchor/Camera3D/GameUI/Timer.text = timer_text

func _input(event): #called on inputs(mouse movements and keypressed)
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		$CameraAnchor.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraAnchor.rotation.x = clampf($CameraAnchor.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	
	elif event is InputEventKey:
		if event.keycode == KEY_SPACE and is_on_floor(): #queues a jump for the next physics tick
			should_jump = true
		
		if event.keycode == KEY_ESCAPE and not event.is_echo():
			game_running = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			$CameraAnchor/Camera3D/EscapeMenu.visible = true

func update_velocity_feed() -> void: #updates a debug feed for velocities
	#actual velocities
	var velX = snapped(velocity.x,0.1)
	var velY = snapped(velocity.y,0.1)
	var velZ = snapped(velocity.z,0.1)
	$CameraAnchor/Camera3D/DebugUI/VelocityDebug.text = "VelX:"+str(velX)+" VelY:"+str(velY)+" VelZ:"+str(velZ)
	
	#target velocities
	var target_velX = snapped(target_velocity.x,0.1)
	var target_velY = snapped(target_velocity.y,0.1)
	var target_velZ = snapped(target_velocity.z,0.1)
	$CameraAnchor/Camera3D/DebugUI/TargetVelocityDebug.text = "TVelX:"+str(target_velX)+" TVelY:"+str(target_velY)+" TVelZ:"+str(target_velZ)


func add_velocity(added_velocity:Vector3) -> void: #function to be called by other things, to add or remove velocity
	print("[Runner] Velocity increase called, increasing by "+str(added_velocity)+" at the end of the current physics frame")
	velocity_increase = added_velocity

func multiply_all_velocity(multiplier:float) -> void: #function to be called by other things and here, to mutliply velocity
	print("[Runner] Velocity multiplier called, multiplying by "+str(multiplier)+" at the end of the current physics frame")
	single_velocity_multiplier = multiplier


func _physics_process(delta: float) -> void: #runs at a fixed rate, useful for physics based things like movement, you then multiply by delta, which is the time between ticks(updates)	
	if game_running:
		var target_acceleration = Vector3.ZERO
		var applied_acceleration = sprint_acceleration #speed that is applied to the player when they are moving
		
		#gravity handling
		if not is_on_floor():
			target_velocity += get_gravity() * delta
		elif is_on_floor():
			target_velocity.y = 0
		target_velocity.y = clamp(target_velocity.y,-terminal_fall_velocity,9223372036854775807)
		
		if should_jump == true and is_on_floor(): #jumping
			target_velocity.y += jump_velocity
			multiply_all_velocity(1.2)
			should_jump = false
		
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
		
		#z axis movement application, caps running speed to not add speed if we are more than the max speed
		if abs(target_velocity.z) < max_sprint_speed:# or sign(target_acceleration.z) != sign(target_velocity.z):
			target_velocity.z += target_acceleration.z
		
		#x axis movement application, caps running speed to not add speed if we are more than the max speed
		if abs(target_velocity.x) < max_sprint_speed or sign(target_acceleration.x) != sign(target_velocity.x):
			target_velocity.x += target_acceleration.x
		
		#target_velocity = target_velocity.rotated(Vector3.UP,rotation.y) # TODO: this is wrong, needs fixing to rotate properly. Should use a third variable to get total movement speed
		
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
		velocity = transform.basis * velocity #rotate velocity to be relative to player rotation
		
		update_velocity_feed()
		move_and_slide()
		
		var impact = get_last_slide_collision()
		if impact != null and not is_on_floor():
			var collider = impact.get_collider()
			var bounce = collider.physics_material_override.bounce
			
			var impact_normal = impact.get_normal()
			#impact_normal *= bounce
			#impact_normal = impact_normal.normalized()
					
			velocity = velocity.bounce(impact_normal)
			velocity *= bounce
			target_velocity = velocity
			
			impact = null
			impact = move_and_collide(velocity*delta)
