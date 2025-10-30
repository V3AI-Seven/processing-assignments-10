extends StaticBody3D
var boost_multiplier = 1

func _ready() -> void:
	boost_multiplier = get_meta("BoostMultiplier")

func boost_player(object:Node3D) -> void:
	object.call("multiply_all_velocity",boost_multiplier)
