class_name RoomManager
extends Node

@export var initial_room: String
@export var initial_player_pos: Vector2
@export var initial_lucidity: float
var current_room: Room

@export var rooms: Dictionary[String, PackedScene]

func _ready() -> void:
	change_room(initial_room)
	Game.event_manager.change_room.connect(change_room)
	Game.player.position = initial_player_pos
	Game.event_manager.set_lucidity(initial_lucidity)

func change_room(room: String):
	if current_room: current_room.queue_free()
	
	var room_instance = rooms[room].instantiate()
	current_room = room_instance
	get_parent().add_child.call_deferred(room_instance)
	room_instance.initialize(room)
