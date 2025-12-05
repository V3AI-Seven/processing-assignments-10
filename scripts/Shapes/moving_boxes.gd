extends Node2D
signal player_hit



func start_game() -> void: #linked via signal
	$SlidingBox/TriggerTimer.start()
	$SlidingBox2/TriggerTimer.start()
	$SlidingBox3/TriggerTimer.start()

func stop_game() -> void:
	$SlidingBox/TriggerTimer.stop()
	$SlidingBox2/TriggerTimer.stop()
	$SlidingBox3/TriggerTimer.stop()

func object_collide(object: Node2D) -> void: #linked via signal to moving things
	if object.get_meta("IsPlayer", false):
		player_hit.emit()

func sliding_box_1() -> void: #linked via signal
	$SlidingBox/AnimationPlayer.play("SlidingBox")
func sliding_box_2() -> void: #linked via signal 
	$SlidingBox2/AnimationPlayer.play("SlidingBox2/SlidingBox")
func sliding_box_3() -> void:#linked via signal
	$SlidingBox3/AnimationPlayer.play("SlidingBox1/SlidingBox")
