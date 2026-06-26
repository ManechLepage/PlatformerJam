class_name FallWater
extends Water

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	on_lucidity_changed()

func on_lucidity_changed() -> void:
	if ray_cast_2d.is_colliding():
		var height: float = ray_cast_2d.get_collision_point().y
		collision_shape_2d.scale.y = height - global_position.y
		collision_shape_2d.position.y = (height-global_position.y)/2
		$Sprite2D.region_rect = Rect2(0,0,64*3,height-global_position.y)
		$Sprite2D.position.y = (height-global_position.y)/2
