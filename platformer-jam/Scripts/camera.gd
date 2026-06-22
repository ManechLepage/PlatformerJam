class_name CameraManager
extends Camera2D

var shake_fade: float = 10.0
var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var shake: float = 0.0

func set_shake(shake_value: float) -> void:
	shake = shake_value

func clear_shake() -> void:
	shake = 0.0

func _process(delta: float) -> void:
	shake_strength = lerpf(shake_strength, shake, shake_fade * delta)
	offset = random_offset()

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
