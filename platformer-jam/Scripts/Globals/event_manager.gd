class_name EventManager
extends Node

signal lucidity_changed(value)
signal change_room(room: String)

signal received_floor(node: Node2D)
signal exit_floor(node: Node2D)

func set_lucidity(value):
	Game.lucidity = value

func change_lucidity(value):
	Game.lucidity += value
