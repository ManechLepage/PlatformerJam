class_name Water
extends Area2D

@export var active: bool = true:
	set(value):
		active = value
		active_changed(value)

@export var is_always_active = false

func _on_body_entered(body: Node2D) -> void:
	if not active or not body is Player: return
	Game.event_manager.interactable_object = self
	if is_always_active: Game.player.interact.is_washing = true

func _on_body_exited(body: Node2D) -> void:
	if not active or not body is Player: return
	Game.event_manager.interactable_object = null
	if is_always_active: Game.player.interact.is_washing = false

func active_changed(value):
	pass
