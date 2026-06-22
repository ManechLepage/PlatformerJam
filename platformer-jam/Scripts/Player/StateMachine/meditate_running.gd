extends State

@export var meditation_power: float

@export var idle: State
@export var run: State
@export var fall: State
@export var meditate_idle: State
@export var jump: State

func enter():
	super()
	#parent.sprite.play("Meditation Run")

func process_inputs(event):
	if Input.is_action_just_released("Meditate"):
		return run
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump

func process_physics(delta):
	Game.event_manager.change_lucidity(meditation_power)
	var direction = Input.get_axis("Left", "Right")
	
	flip_character(direction)
	
	if direction != 0:
		parent.velocity.x = move_toward(parent.velocity.x, direction * move_speed * 0.5, acceleration * delta)
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if direction == 0:
		return meditate_idle
	if parent.velocity.y > 0:
		return fall
