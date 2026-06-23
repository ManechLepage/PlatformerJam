class_name Platform
extends AnimatableBody2D

@export var is_platform: bool = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	if is_platform: collision_shape_2d.one_way_collision = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Down"):
		if not is_platform: return
		collision_shape_2d.disabled = true
	if Input.is_action_just_released("Down"):
		if not is_platform: return
		collision_shape_2d.disabled = false
