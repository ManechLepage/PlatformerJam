class_name Water
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player: Game.event_manager.interactable_object = self

func _on_body_exited(body: Node2D) -> void:
	if body is Player: Game.event_manager.interactable_object = null
