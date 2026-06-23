class_name TweenAnimations
extends Node

func animate_object_displacement(object: Node2D, offset: Vector2, time: float) -> void:
	var tween = create_tween()
	tween.tween_property(object, "position", offset, time).as_relative().set_ease(Tween.EASE_OUT)

func animate_object_rotation(object: Node2D, rotation: float, time: float) -> void:
	var tween = create_tween()
	tween.tween_property(object, "rotation", rotation, time).as_relative().set_ease(Tween.EASE_OUT)

func animate_transform(object: Node2D, offset: Vector2, rotation: float, time: float) -> void:
	var tween = create_tween()
	tween.tween_property(object, "position", offset, time).as_relative().set_ease(Tween.EASE_OUT)
	tween.tween_property(object, "rotation", rotation, time).as_relative().set_ease(Tween.EASE_OUT)
	tween.set_parallel(true)
