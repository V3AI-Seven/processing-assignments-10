extends Node2D
const SPAWN_ANGLES := [180,195,210,225,240,255,270]
const SPAWN_ANGLE_MODIFIERS := [0,5,-5]
const SPAWN_VELOCITY := Vector2(450,0)

var total_spawns := 0
var modifier_index := 0

var particle_clones := []


func spawn_particle(angle:int) -> void:
	randomize()
	var spawn_angle := randf_range(angle-2.5,angle+2.5) # slightly variates the angle
	
	var particle_clone := $Particle.duplicate() #cloning the object
	add_child(particle_clone)
	#a bunch of setup for the object
	particle_clone.rotation_degrees = spawn_angle #visually rotates the particle
	particle_clone.global_position = $SpawnLocation.global_position #sets the particle's position
	particle_clone.velocity = SPAWN_VELOCITY.rotated(deg_to_rad(spawn_angle)) #sets the particles velocity to be the direction it should be going
	print("Spawned particle clone at " + str(particle_clone.global_position) + " with rotation " + str(particle_clone.rotation_degrees) + " with velocity " + str(particle_clone.velocity))
	
	particle_clones.append(particle_clone)


func start_game() -> void: #linked with signal
	$TriggerTimer.start()

func end_game() -> void:#linked with signal
	$TriggerTimer.stop()
	$EmitTimer.stop()


func start_particles() -> void:#linked with signal
	$EmitTimer.start()
	$RunTime.start()

func stop_particles() -> void:#linked with signal
	$EmitTimer.stop()
	await get_tree().create_timer(6).timeout
	kill_particles()

func kill_particles() -> void:
	for particle in particle_clones:
		particle.queue_free() #removes the clones from the tree

func emit_particles() -> void:#linked with signal
	print("Particle emission triggered")
	total_spawns += 1
	
	for angle in SPAWN_ANGLES:
		spawn_particle(angle+SPAWN_ANGLE_MODIFIERS[modifier_index])
	
	modifier_index += 1
	if modifier_index > 2:
		modifier_index = 0
