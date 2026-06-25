@tool
extends Node2D

@export var offset: Vector2i:
	set(value):
		offset = value
		position = Vector2(offset.x * -960.0, offset.y * -540.0)
