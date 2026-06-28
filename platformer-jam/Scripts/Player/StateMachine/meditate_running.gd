extends State

@export var meditation_power: float

@export var idle: State
@export var run: State
@export var fall: State
@export var meditate_idle: State
@export var jump: State

var progress: float = 0.0

func enter():
	super()
	Game.player.sprite.play("meditate_end")

func exit():
	super()
	Game.clear_shake()
	parent.is_meditating = false

func process_inputs(event):
	if Input.is_action_pressed("Meditate"):
		Game.start_meditation_animation()
		parent.is_meditating = true
	else:
		parent.is_meditating = false
		Game.clear_shake()


func process_physics(delta):
	if parent.is_meditating or progress > 8: progress += delta
	Game.world_env.environment.adjustment_brightness = (ease(progress/13,2.3)*13)
	$"../../Sounds/meditate".max_vol = 1-(ease(progress/15,5))
	Game.audio_manager.set_noise_level(1-(ease(progress/15,1)))
	if progress>15:
		Game.credits.start_credits()
		$"../../Sounds/meditate".max_vol = 0
		Game.audio_manager.set_noise_level(0)
		return idle
	
	return null
