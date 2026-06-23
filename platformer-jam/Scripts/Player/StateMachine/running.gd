extends State

@export var jump: State
@export var idle: State
@export var fall: State
@export var meditate_running: State
@export var interact: State

func enter():
	super()
	Game.player.sprite.play("running")

func process_inputs(event):
	if Input.is_action_just_released("Interact"):
		return interact
	if Input.is_action_just_pressed("Meditate"):
		return meditate_running
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump

func process_physics(delta):
	var direction = Input.get_axis("Left", "Right")
	
	flip_character(direction)
	
	if direction != 0:
		parent.velocity.x = move_toward(parent.velocity.x, direction * move_speed, acceleration * delta)
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if direction == 0:
		return idle
	if parent.velocity.y > 0:
		return fall
