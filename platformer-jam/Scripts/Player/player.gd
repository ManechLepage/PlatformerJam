class_name Player
extends CharacterBody2D

var facing_right: bool = true
var has_jumped: bool = false
var speed: float = 0.0
var is_meditating: bool = false

@onready var state_machine: StateMachine = $StateMachine
@export var sprite: AnimatedSprite2D
@export var interact_area: Area2D
@onready var icon: Sprite2D = $Icon

@onready var running: State = $StateMachine/Running
@onready var idle: State = $StateMachine/Idle
@onready var jump: State = $StateMachine/Jump
@onready var fall: State = $StateMachine/Fall

var ground_info: Node2D

func _ready() -> void:
	state_machine.init(self)
	Game.event_manager.interactable_object_changed.connect(update_x_icon)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func _unhandled_input(event):
	state_machine.process_inputs(event)

func _on_floor_info_body_entered(body: Node2D) -> void:
	Game.event_manager.received_floor.emit(body)

func _on_floor_info_body_exited(body: Node2D) -> void:
	Game.event_manager.exit_floor.emit(body)

func update_x_icon() -> void:
	if Game.event_manager.interactable_object: icon.visible = true
	else: icon.visible = false
