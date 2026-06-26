class_name Game_Manager
extends Node

@onready var audio_manager: AudioManager = $AudioManager
@onready var event_manager: EventManager = $EventManager
@onready var tween_animations_manager: TweenAnimations = $TweenAnimationsManager

var lucidity: float = 0:
	set(value):
		lucidity = max(value, 0)
		event_manager.lucidity_changed.emit(value)
var lucidity_target: float = 0.0:
	set(value):
		lucidity_target = max(value, -0.07)
var max_lucidity: float = 60.0
var camera: CameraManager
var player: Player
@export var lever_states: Array[bool]

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	event_manager.received_floor.connect(set_ground)
	event_manager.exit_floor.connect(clear_ground)

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
	if abs(lucidity - lucidity_target) > 0.05:
		lucidity = lerpf(lucidity, lucidity_target, 5.0 * delta)
	if lucidity_target > max_lucidity:
		lucidity_target = lerpf(lucidity_target, max_lucidity, delta * 6)

func set_ground(node: Node2D) -> void:
	if node is AnimationObject: node.is_ground = true

func clear_ground(node: Node2D) -> void:
	if node is AnimationObject: node.is_ground = false
