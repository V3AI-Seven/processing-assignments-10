extends CharacterBody2D
var is_clone = false

func _ready() -> void:
	if is_clone:
		var spawn_side = randi_range(1,4)
		var spawnX
		var spawnY
		match spawn_side:
			1: #negative x
				spawnX = randi_range(64,1088)
				spawnY = 736
				
			2: #positive x
				spawnX = randi_range(64,1088)
				spawnY = 96
				
			3: #negative y
				spawnX = -64
				spawnY = randi_range(64,576)
				
			4: #positive y
				spawnX = 1216
				spawnY = randi_range(64,576)
		
		
		position.x = spawnX
		position.y = spawnY
		
		visible = true
		
		print("Clone ready")
		
	else:
		print("Not clone")
		visible = false

func new_boulder() -> void: # TODO: still need to connect to timer and test
	print("Generating new boulder")
	
	var boulder_clone = duplicate()
	boulder_clone.is_clone = true
	
	get_tree().current_scene.add_child(boulder_clone)
	

func _physics_process(delta) -> void:
	if is_clone == true:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
