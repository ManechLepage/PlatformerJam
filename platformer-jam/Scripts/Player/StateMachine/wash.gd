extends State

@export var wash_power = 0.02

@export var idle: State
var is_washing: bool = false

func enter():
	super()
	Game.player.sprite.play("idle")
	if Game.event_manager.interactable_object: interact()


func process_inputs(event):
	if Input.is_action_just_released("Interact"):
		return idle
	return null

func process_physics(delta):
	if is_washing: Game.event_manager.change_lucidity(-wash_power)
	return null

func interact() -> void:
	if Game.event_manager.interactable_object is Water:
		is_washing = true
