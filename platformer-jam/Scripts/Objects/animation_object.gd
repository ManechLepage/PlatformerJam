class_name AnimationObject
extends AnimatableBody2D

@export var max_y_offset: float
@export var displacement_speed: float
var original_pos
var progress: float = 0.0

var is_ground: bool = false

func _ready() -> void:
	original_pos = position

func animate_up(delta: float) -> void:
	progress += delta
	progress = min(progress, 1)
	position.y = lerpf(position.y, original_pos.y, progress * displacement_speed)

func animate_down(delta: float) -> void:
	progress -= delta
	progress = max(progress, 0)
	position.y = lerpf(position.y, original_pos.y + max_y_offset, progress * displacement_speed)

func _physics_process(delta: float) -> void:
	if is_ground: animate_down(delta)
	else: animate_up(delta)
