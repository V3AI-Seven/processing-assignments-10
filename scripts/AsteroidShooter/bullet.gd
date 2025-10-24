extends CharacterBody2D

const fire_speed = 800 #pixels/s

var is_shot = false
var score = 0

signal point_scored(scored:int)

func score_point(object):#linked with signal
	if is_shot == true:
		print("[Asteroid] bullet hit something")
		print(str(object))
		if object.has_meta("is_in_play") == true and object.get_meta("is_in_play") == true:
			print("[Asteroid] bullet hit a boulder")
			object.queue_free()
			point_scored.emit(1)
			queue_free()

func _ready() -> void:# runs when loaded(normally or as clone)	
	if is_shot == true:
		#print("[Asteroid] Bullet shot!")
		visible = true
	else:
		#print("[Asteroid] Regular bullet")
		visible = false

func fire_shot():#linked with signal
	#print("[Asteroid] Bullet cloned")
	var bullet_clone = duplicate()
	
	bullet_clone.is_shot = true
	bullet_clone.visible = true
	
	get_tree().current_scene.add_child(bullet_clone)

#linked with signal
func recieve_position(incoming_position:Vector2, incoming_rotation:float): #used to ensure bullet tracks with player
	if is_shot == false:
		position = incoming_position
		rotation = incoming_rotation

func _physics_process(_delta: float) -> void: #runs at a fixed rate, and delta is time between ticks(updates)
	if is_shot == true:
		velocity = global_transform.y * -fire_speed
		move_and_slide()
