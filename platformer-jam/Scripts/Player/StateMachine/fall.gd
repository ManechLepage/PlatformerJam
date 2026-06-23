extends State

@export var gravity_multiplier: float = 1.8

@onready var timer = $CoyoteJump
@onready var input_delay_timer = $InputDelay
@export var double_jump: State
@export var jump: State
@export var run: State
@export var idle: State

var can_control: bool = true

func enter():
	Game.player.velocity.y = max(Game.player.velocity.y, 80+Game.player.velocity.y/2) #quick release makes u instant fall
	timer.start()
	super()

func exit():
	can_control = true

func process_inputs(event):
	if Input.is_action_just_pressed("Jump"):
		if timer.time_left > 0 and !parent.has_jumped:
			return jump
		elif timer.time_left > 0 and Game.player.interact_area.get_overlapping_areas():
			return double_jump
		else:
			input_delay_timer.start()
	return null

func process_physics(delta):
	var movement = Input.get_axis("Left", "Right") * move_speed
	#flip_character(movement)
	
	parent.velocity.y += gravity * delta * gravity_multiplier
	if can_control:
		parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		parent.has_jumped = false
		if input_delay_timer.time_left > 0:
			return jump
		if movement != 0:
			return run
		return idle
	return null
