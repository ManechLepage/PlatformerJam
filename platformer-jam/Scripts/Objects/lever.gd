class_name Lever
extends Area2D

signal on_activated()

@export var base: AnimatedSprite2D
var activated = false

func _on_area_entered(area: Node2D) -> void:
	if area == Game.player.interact_area: Game.event_manager.interactable_object = self

func _on_area_exited(area: Node2D) -> void:
	if area == Game.player.interact_area: Game.event_manager.interactable_object = null

func activate():
	activated = not activated
	base.frame = activated as int
	on_activated.emit()
