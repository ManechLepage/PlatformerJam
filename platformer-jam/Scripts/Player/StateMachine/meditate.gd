extends State

@export var meditation_power: float

@export var idle: State
@export var fall: State
@export var running: State
@export var jump: State
@export var meditate_end: State


func enter():
	super()
		
	Game.start_meditation_animation()
	parent.is_meditating = true
	Game.player.sprite.play("meditation_idle")

func exit():
	super()
	if Game.max_lucidity != 100:
		parent.is_meditating = false
		Game.clear_shake()

func process_inputs(event):
	if Input.is_action_just_released("Meditate"):
		Game.player.sprite.play("meditation_idle",-1)
		return idle
	if Input.is_action_just_pressed("Jump"):
		return jump
	if Game.max_lucidity == 100:
		
		return meditate_end
	return null

	

func process_physics(delta):
	Game.event_manager.change_lucidity(meditation_power*delta)
	
	parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	if not parent.is_on_floor():
		return fall
	
	return null
