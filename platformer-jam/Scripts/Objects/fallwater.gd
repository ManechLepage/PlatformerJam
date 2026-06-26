class_name FallWater
extends Water

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	Game.event_manager.lucidity_changed.connect(on_lucidity_changed)
	await get_tree().create_timer(0.03).timeout
	on_lucidity_changed(0.0)


func on_lucidity_changed(value) -> void:
	if ray_cast_2d.is_colliding():
		var height: float = ray_cast_2d.get_collision_point().y
		collision_shape_2d.shape.size.y = height - global_position.y
		collision_shape_2d.position.y = collision_shape_2d.shape.size.y / 2
