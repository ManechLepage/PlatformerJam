class_name Game_Manager
extends Node

@onready var audio_manager: AudioManager = $AudioManager
@onready var event_manager: EventManager = $EventManager

var lucidity: float = 0

func _ready() -> void:
	#lucid_test()
	pass

func lucid_test():
	event_manager.change_lucidity(1)
	await get_tree().create_timer(0.1).timeout
	lucid_test()
