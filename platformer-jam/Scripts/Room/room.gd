class_name Room
extends Node2D

var initial_player_pos: Vector2
var room_name: String

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	initial_player_pos = Game.player.global_position

func initialize(_room_name: String) -> void:
	room_name = _room_name

func _on_room_trigger_change_room(room: String) -> void:
	Game.event_manager.change_room.emit(room)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Restart"):
		await get_tree().create_timer(2.0).timeout
		Game.player.global_position = initial_player_pos
		Game.event_manager.change_room.emit(room_name)
