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
	Game.player.velocity.y = max(Game.player.velocity.y, -130) #quick release makes u instant fall
	timer.start()
	super()
	if not (Game.player.sprite.animation in ["jump","running"]):
		Game.player.sprite.play("fall")

func exit():
	can_control = true

func process_inputs(event):
	if Input.is_action_just_pressed("Jump"):
		return jump
		if timer.time_left > 0 and !parent.has_jumped:
			pass
		
		elif Game.player.interact_area.get_overlapping_areas():
			return double_jump
		else:
			input_delay_timer.start()
	return null

func process_physics(delta):
	var movement = Input.get_axis("Left", "Right") * move_speed
	#flip_character(movement)
	
	parent.velocity.y += gravity * delta * gravity_multiplier
	parent.velocity.y = min(parent.velocity.y,max_fall_speed)
	if can_control:
		parent.velocity.x = movement
	parent.move_and_slide()
	
	if Game.player.sprite.animation == "jump" and parent.velocity.y >=0:
		Game.player.sprite.play("fall")
	
	if parent.is_on_floor():
		parent.has_jumped = false
		if input_delay_timer.time_left > 0:
			flip_character(movement)
			return jump
		if movement != 0:
			return run
		return idle
	elif input_delay_timer.time_left > 0 and Game.player.interact_area.get_overlapping_areas():
		return double_jump
	
	return null
