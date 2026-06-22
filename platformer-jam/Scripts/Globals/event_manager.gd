class_name EventManager
extends Node

signal lucidity_changed(value)

func set_lucidity(value):
	Game.lucidity = value
	lucidity_changed.emit(Game.lucidity)

func change_lucidity(value):
	Game.lucidity += value
	lucidity_changed.emit(Game.lucidity)
