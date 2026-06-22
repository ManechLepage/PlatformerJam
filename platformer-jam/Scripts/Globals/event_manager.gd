class_name EventManager
extends Node

signal lucidity_changed(value)
signal change_room(room: String)

func set_lucidity(value):
	Game.lucidity = value

func change_lucidity(value):
	Game.lucidity += value
