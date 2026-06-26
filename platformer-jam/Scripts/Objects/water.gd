class_name Water
extends Area2D

@export var active: bool = true:
	set(value):
		active = value
		if active != value: active_changed(value)

@export var is_always_active = false

@export var sprite: AnimatedSprite2D

func active_changed(value):
	sprite.play("active" if value else "inactive")
	monitorable = value
	monitoring = value
