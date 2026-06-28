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

func process_physics(delta):
	progress += delta
	
