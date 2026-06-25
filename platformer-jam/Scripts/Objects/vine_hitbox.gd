class_name VineHitbox
extends AnimatableBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func load_hitbox(rect: Rect2) -> void:
	collision_shape_2d.shape.size = rect.size
