extends Node2D
signal player_hit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func start_game() -> void:
	$SlidingBox/TriggerTimer.start()
	$SlidingBox2/TriggerTimer.start()
	$SlidingBox3/TriggerTimer.start()

func object_collide(object: Node2D) -> void:
	if object.get_meta("IsPlayer", false):
		player_hit.emit()

func sliding_box_1() -> void:
	$SlidingBox/AnimationPlayer.play("SlidingBox")
func sliding_box_2() -> void:
	$SlidingBox2/AnimationPlayer.play("SlidingBox2/SlidingBox")
func sliding_box_3() -> void:
	$SlidingBox3/AnimationPlayer.play("SlidingBox1/SlidingBox")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
