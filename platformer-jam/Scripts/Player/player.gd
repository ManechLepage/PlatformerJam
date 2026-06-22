class_name Player
extends CharacterBody2D

var facing_right: bool = true
var sprite: AnimatedSprite2D
var has_jumped: bool = false

@onready var state_machine: StateMachine = $StateMachine

@onready var running: State = $StateMachine/Running
@onready var idle: State = $StateMachine/Idle
@onready var jump: State = $StateMachine/Jump
@onready var fall: State = $StateMachine/Fall

func _ready() -> void:
	state_machine.init(self)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func _unhandled_input(event):
	state_machine.process_inputs(event)
