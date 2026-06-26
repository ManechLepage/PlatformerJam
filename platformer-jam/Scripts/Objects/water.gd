class_name Water
extends Area2D

@export var active: bool = true:
	set(value):
		active = value
		if active != value: active_changed(value)

@export var is_always_active = false

@export var sprite: AnimatedSprite2D
func _ready() -> void:
	active_changed(active)

func active_changed(value):
	sprite.play("active" if value else "inactive")
	$Area/Parchemin.visible = active
	monitorable = value
	monitoring = value
