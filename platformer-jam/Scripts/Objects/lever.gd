class_name Lever
extends Area2D

signal on_activated()

func _on_area_entered(area: Node2D) -> void:
	if area == Game.player.interact_area: Game.event_manager.interactable_object = self

func _on_area_exited(area: Node2D) -> void:
	if area == Game.player.interact_area: Game.event_manager.interactable_object = null

func activate():
	on_activated.emit()
