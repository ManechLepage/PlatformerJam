class_name Room
extends Node2D

func _on_room_trigger_change_room(room: PackedScene) -> void:
	Game.event_manager.change_room.emit(room)
