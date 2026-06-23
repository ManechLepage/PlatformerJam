extends State

@export var meditation_power: float

@export var idle: State
@export var fall: State
@export var meditate_running: State

func enter():
	super()
	Game.start_meditation_animation()
	parent.is_meditating = true
	Game.player.sprite.play("meditation_idle")

func exit():
	super()
	parent.is_meditating = false
	Game.clear_shake()

func process_inputs(event):
	if Input.is_action_just_released("Meditate"):
		Game.player.sprite.play("meditation_idle",-1)
		return idle
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return meditate_running
	return null

func process_physics(delta):
	Game.event_manager.change_lucidity(meditation_power)
	
	parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if Input.get_axis("Left", "Right") != 0:
		return meditate_running
	
	return null
