extends State

@export var meditation_power: float

@export var idle: State
@export var fall: State
@export var meditate_running: State

func enter():
	super()
	#parent.sprite.play("Idle")
	parent.velocity.x = 0

func process_inputs(event):
	if Input.is_action_just_released("Meditate"):
		return idle
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return meditate_running
	return null

func process_physics(delta):
	Game.event_manager.change_lucidity(meditation_power)
	print(Game.lucidity)
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall
	
	var movement = Input.get_axis("Left", "Right") * move_speed
	if movement != 0:
		return meditate_running
	return null
