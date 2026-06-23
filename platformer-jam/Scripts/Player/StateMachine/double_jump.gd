extends State
@onready var input_delay_timer = $InputDelay
@export var idle: State
@export var run: State
@export var fall: State
@export var jump: State
@export var double_jump: State
@export var jump_force: float = 500.0


func enter():
	super()
	parent.velocity.y = -jump_force
	parent.has_jumped = true
	Game.player.sprite.play("jump")
	if not Input.is_action_pressed("Jump"):
		return fall

func process_inputs(event):
	if Input.is_action_just_pressed("Jump"):
		if Game.player.interact_area.get_overlapping_areas():
			return double_jump
		else:
			input_delay_timer.start()
	return null

func process_physics(delta):
	parent.velocity.y += gravity * delta
	
	var direction = Input.get_axis("Left", "Right")
	var movement = move_toward(parent.velocity.x, direction * move_speed, acceleration * delta)
	#flip_character(direction)
	
	if movement != 0:
		pass # Flip animation
	
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall
	
	if parent.is_on_floor():
		parent.has_jumped = false
		if input_delay_timer.time_left > 0:
			return jump
		if movement != 0:
			return run
		return idle
	return null
