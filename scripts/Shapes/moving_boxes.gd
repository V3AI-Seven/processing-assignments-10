extends Node2D
signal player_hit

var timers := []

func _ready() -> void:
	timers.append($SlidingBox/TriggerTimer)
	timers.append($SlidingBox2/TriggerTimer)
	timers.append($SlidingBox3/TriggerTimer)
	timers.append($SlidingBox4/TriggerTimer)
	timers.append($SlidingBox5/TriggerTimer)
	timers.append($SlidingBox6/TriggerTimer)
	

func start_game() -> void: #linked via signal
	for timer in timers:
		timer.start()

func stop_game() -> void:
	for timer in timers:
		timer.stop()
	
func object_collide(object: Node2D) -> void: #linked via signal to moving things
	if object.get_meta("IsPlayer", false):
		player_hit.emit()

func sliding_box_1() -> void: #linked via signal
	$SlidingBox/AnimationPlayer.play("SlidingBox")
func sliding_box_2() -> void: #linked via signal 
	$SlidingBox2/AnimationPlayer.play("SlidingBox2/SlidingBox")
func sliding_box_3() -> void:#linked via signal
	$SlidingBox3/AnimationPlayer.play("SlidingBox1/SlidingBox") #don't mind the weird names, it works, but I don't really know why they got named like that
func sliding_box_4() -> void: #linked via signal 
	$SlidingBox4/AnimationPlayer.play("SlidingBox4/SlidingBox")
func sliding_box_5() -> void: #linked via signal 
	$SlidingBox5/AnimationPlayer.play("SlidingBox5/SlidingBox")
func sliding_box_6() -> void: #linked via signal 
	$SlidingBox6/AnimationPlayer.play("SlidingBox6/SlidingBox")
