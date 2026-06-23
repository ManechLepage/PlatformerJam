class_name Platform
extends AnimatableBody2D

@export var is_platform: bool = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var polygon_2d: Polygon2D = $Polygon2D

func _ready() -> void:
	if is_platform: collision_shape_2d.one_way_collision = true
