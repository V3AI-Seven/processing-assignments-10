extends CharacterBody2D
signal player_hit

func _ready() -> void:
	velocity = Vector2.ZERO # velocity intialized (kind of, its not necessary because it is inbuilt, but good practice)

func object_hit(object: Node2D) -> void: #linked with signal
	if object.get_meta("IsPlayer", false):
		player_hit.emit() #signal to trigger the player death code

func _physics_process(delta: float) -> void:
	move_and_slide() # inbuilt function that runs movement and collision
