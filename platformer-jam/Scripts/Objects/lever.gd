class_name Lever
extends Area2D

var activated: bool = false
signal on_activated

func _on_body_entered(body: Node2D) -> void:
	if body is Player: Game.event_manager.interactable_object = self

func _on_body_exited(body: Node2D) -> void:
	if body is Player: Game.event_manager.interactable_object = null

func activate():
	activated = true
	on_activated.emit()
