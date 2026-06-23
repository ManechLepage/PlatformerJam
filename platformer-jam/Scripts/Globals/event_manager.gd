class_name EventManager
extends Node

signal lucidity_changed(value)
signal change_room(room: String)

signal received_floor(node: Node2D)
signal exit_floor(node: Node2D)

signal interactable_object_changed

var interactable_object: Area2D:
	set(value):
		interactable_object = value
		interactable_object_changed.emit()

func set_lucidity(value):
	Game.lucidity_target = value

func change_lucidity(value):
	Game.lucidity_target += value
