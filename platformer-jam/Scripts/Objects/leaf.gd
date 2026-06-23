extends AnimatableBody2D

@export var y_offset: float

func animate_down() -> void:
	Game.animate_object_displacement(self, Vector2(0, -y_offset))

func animate_up() -> void:
	Game.animate_object_displacement(self, Vector2(0, y_offset))
