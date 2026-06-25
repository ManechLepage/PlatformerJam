class_name Water
extends Area2D

@export var min_water: float = 0.0
@export var is_always_active = false

func _on_body_entered(body: Node2D) -> void:
	if not body is Player: return
	Game.event_manager.interactable_object = self
	if is_always_active: Game.player.interact.is_washing = true

func _on_body_exited(body: Node2D) -> void:
	if not body is Player: return
	Game.event_manager.interactable_object = null
	if is_always_active: Game.player.interact.is_washing = false
