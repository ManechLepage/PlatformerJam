extends State

@export var wash_power = 0.02

@export var idle: State

func enter():
	super()
	Game.player.sprite.play("idle")


func process_inputs(event):
	if Input.is_action_just_released("Interact"):
		return idle
	return null

func process_physics(delta):
	#Game.event_manager.change_lucidity(-wash_power)
	return null
