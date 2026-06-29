class_name Lever
extends Area2D

signal on_activated()

@export var base: AnimatedSprite2D
@export var poem_text: RichTextLabel
var activated = false
var hover:= false
var progress:= 0.0

func _on_area_entered(area: Node2D) -> void:
	if area == Game.player.interact_area: 
		hover = true
		Game.event_manager.interactable_object = self

func _on_area_exited(area: Node2D) -> void:
	if area == Game.player.interact_area: 
		hover = false
		Game.event_manager.interactable_object = null

func activate():
	activated = not activated
	base.frame = activated as int
	on_activated.emit()
	
func _process(delta: float) -> void:
	if hover:
		progress += delta
		poem_text.visible_characters = int(progress*20)
		if poem_text.modulate.a < 1:
			poem_text.modulate.a += delta*3
	elif poem_text:
		if poem_text.modulate.a > 0:
			poem_text.modulate.a -= delta*3
