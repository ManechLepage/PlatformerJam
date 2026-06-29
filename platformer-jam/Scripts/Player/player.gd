class_name Player
extends CharacterBody2D

var facing_right: bool = true
var has_jumped: bool = false
var speed: float = 0.0
var is_meditating: bool = false
var poem_collected: int = 0
var is_flipping_on_landing: bool = false

@onready var state_machine: StateMachine = $StateMachine
@export var sprite: AnimatedSprite2D
@export var interact_area: Area2D
@export var wash_area: Area2D
@export var wash_no_consent_area: Area2D
@export var wash_timer: Timer
@onready var icon: Sprite2D = $Icon

@onready var running: State = $StateMachine/Running
@onready var idle: State = $StateMachine/Idle
@onready var jump: State = $StateMachine/Jump
@onready var fall: State = $StateMachine/Fall
@onready var interact: State = $StateMachine/Interact

var is_washing: bool = false
var forced_washing: bool = false

var ground_info: Node2D

func _ready() -> void:
	state_machine.init(self)
	$Sounds/meditate.volume_linear = 0
	
func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)
	forced_washing = not wash_no_consent_area.get_overlapping_areas().is_empty()
	if forced_washing or is_washing:
		if Game.player.wash_timer.is_stopped(): 
			Game.player.wash_timer.start(1)
			Game.event_manager.change_lucidity(-10)

func _unhandled_input(event):
	state_machine.process_inputs(event)

func _on_floor_info_body_entered(body: Node2D) -> void:
	Game.event_manager.received_floor.emit(body)

func _on_floor_info_body_exited(body: Node2D) -> void:
	Game.event_manager.exit_floor.emit(body)
