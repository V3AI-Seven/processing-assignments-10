extends CharacterBody2D
const bounciness = 0.85 #how much momentum should be kept after bouncing

var move_speed = 200

var is_clone = false
var game_running = false

var impact
var visual_spin_direction = 0
var meteor_texture_index = -1
var clones = []

var visual_rot_speed = 50 #degrees/sec

var meteor_texture_1 = preload("res://scripts/AsteroidShooter/Media/meteor1.png")
var meteor_texture_2 = preload("res://scripts/AsteroidShooter/Media/meteor2.png")
var meteor_texture_3 = preload("res://scripts/AsteroidShooter/Media/meteor3.png")

signal hit_player(hit_position: Vector2)

func _ready() -> void: #runs when the boulder is added to the game(on start or as clone)
	if is_clone:
		move_speed = randi_range(175,300)
		visual_rot_speed = randi_range(40,90) #degrees/sec
		
		visual_spin_direction = randi_range(1,2)
		meteor_texture_index = randi_range(0,2) 
		
		
		match visual_spin_direction: #determine direction that the sprite should spin
			1:
				visual_spin_direction = "left"
			2:
				visual_spin_direction = "right"
		
		match meteor_texture_index: #determines the texture for the meteor
			0:
				$MeteorTexture.texture = meteor_texture_1
			1:
				$MeteorTexture.texture = meteor_texture_2
			2:
				$MeteorTexture.texture = meteor_texture_3
		var spawn_side = randi_range(1,4)
		var spawnX#spawn x coordinate
		var spawnY #spawn y coordinate
		
		var spawnRot # spawning rotation
		#deciding spawn location
		match spawn_side: 
			1: #negative x
				spawnX = randi_range(64,1088)
				spawnY = 736
				
				spawnRot = randf_range(120,240)
				
			2: #positive x
				spawnX = randi_range(64,1088)
				spawnY = -64
				
				spawnRot = randf_range(-120,-240)
				
			3: #negative y
				spawnX = -64
				spawnY = randi_range(64,576)
				
				spawnRot = randf_range(120,30)
				
			4: #positive y
				spawnX = 1216
				spawnY = randi_range(64,576)
				
				spawnRot = randf_range(-120,-30)
		
		position.x = spawnX #set boulder position
		position.y = spawnY#set boulder position
		
		visible = true
		
		rotation_degrees = spawnRot #rotate boulder
		velocity = global_transform.y * -move_speed #rotate velocity to rotation
		
		#print("[Asteroid] Clone ready")
		
	else:
		#print("[Asteroid] Not clone")
		visible = false

func new_boulder() -> void: #function for generating boulder clones, connected with signal to timer
	
	var boulder_clone = duplicate() #clone boulder
	boulder_clone.is_clone = true #tell it it is a clone
	boulder_clone.set_meta("is_in_play", true) #tell it it is being used
	
	clones.append(boulder_clone) #append to list of clones
	
	get_tree().current_scene.add_child(boulder_clone) # actually add it to the scene(making it real)

func start_game() -> void:#connected with signal
	$SpawnTimer.start()
	game_running = true

func destroy() -> void: #used to kill the clone
	if is_clone == true:
		queue_free() # kills the clone

func game_end(_score:int) -> void: #connected with signal
	velocity = Vector2.ZERO #clears the velocity
	$SpawnTimer.stop()
	for clone in clones:
		if clone != null:
			clone.queue_free()#kills the clone

func _physics_process(delta) -> void:#runs at a fixed rate, and delta is time between ticks(updates)
	if is_clone == true:
		#visual rotation
		$MeteorTexture.rotate(deg_to_rad(visual_rot_speed)*delta) #visually rotates the meteor
		
		#collisions and movement from here
		impact = move_and_collide(velocity*delta) #Built in function to have nice movement, velocity, and collision
		
		if impact != null:
			var collider = impact.get_collider() #get the data of the object that hit the asteroid
			if collider.has_meta("is_player") and collider.get_meta("is_player") == true: #check if it is the player
				hit_player.emit(position)
				velocity = Vector2.ZERO
			else:
				var impact_normal = impact.get_normal() # get the normal of the collision
						
				velocity = velocity.bounce(impact_normal) * bounciness #calculate how much the boulder should bounce
				
				impact = null
				impact = move_and_collide(velocity*delta) #calculate motion again, to prevent overwriting velocity
