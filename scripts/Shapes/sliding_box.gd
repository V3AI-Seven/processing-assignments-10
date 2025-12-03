extends AnimatableBody2D
signal player_hit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start_game() -> void:
	$TriggerTimer.start()


func object_hit(body: Node2D) -> void:
	if body.get_meta("IsPlayer", false):
		player_hit.emit()

func play_animation() -> void:
	$AnimationPlayer.play("SlidingBox")
	print("Playing animation")
