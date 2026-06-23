class_name AnimationObject
extends AnimatableBody2D

@export var max_y_offset: float
@export var displacement_speed: float
var original_pos

var is_ground: bool = false

func _ready() -> void:
	original_pos = position

func animate_up(delta: float) -> void:
	position.y -= displacement_speed * delta * 0.05
	position.y = min(position.y, original_pos.y - max_y_offset)

func animate_down(delta: float) -> void:
	position.y += displacement_speed * delta * 0.05
	position.y = max(position.y, original_pos.y)

func _physics_process(delta: float) -> void:
	if is_ground: animate_down(delta)
	else: animate_up(delta)
