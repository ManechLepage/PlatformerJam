class_name Game_Manager
extends Node

@onready var audio_manager: AudioManager = $AudioManager
@onready var event_manager: EventManager = $EventManager

var lucidity: float = 0:
	set(value):
		lucidity = value
		event_manager.lucidity_changed.emit(value)
var max_lucidity: float = 80.0
var camera: CameraManager
var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	#lucid_test()
	pass

func lucid_test():
	event_manager.change_lucidity(1)
	await get_tree().create_timer(0.1).timeout
	lucid_test()

func camera_shake(strength: float):
	camera.set_shake(strength)

func clear_shake():
	camera.clear_shake()

func start_meditation_animation():
	camera_shake(2.0)

func _process(delta: float) -> void:
	if lucidity > max_lucidity:
		lucidity = lerpf(lucidity, max_lucidity, delta * 6)

func animate_object_displacement(object: Node2D, offset: Vector2) -> void:
	var tween = create_tween()
	tween.tween_property(object, "position", offset, 1.0).as_relative().set_ease(Tween.EASE_OUT)
