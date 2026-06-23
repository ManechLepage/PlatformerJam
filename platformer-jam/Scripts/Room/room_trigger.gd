class_name RoomTrigger
extends Area2D

@export var room_name: String



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Game.event_manager.change_room.emit(room_name)
