class_name Game_Manager
extends Node

@onready var audio_manager: AudioManager = $AudioManager
@onready var event_manager: EventManager = $EventManager

var lucidity: float = 0

func _ready() -> void:
	pass
	#lucid_test()

func lucid_test():
	event_manager.change_lucidity(1)
	await get_tree().create_timer(0.01).timeout
	lucid_test()

func camera_shake(strength: float):
	get_tree().get_first_node_in_group("Camera").set_shake(strength)

func clear_shake():
	get_tree().get_first_node_in_group("Camera").clear_shake()

func meditate_camera_shake():
	camera_shake(2.0)
