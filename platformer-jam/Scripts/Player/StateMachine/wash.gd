extends State

@export var wash_power = 0.02
@export var idle: State

var is_washing: bool = false

func enter():
	super()
	Game.player.sprite.play("wash")
	if Game.event_manager.interactable_object: interact()

func exit():
	super()
	is_washing = false

func process_inputs(event):
	if Input.is_action_just_released("Interact"):
		return idle
	return null

func process_physics(delta):
	return null

func wash(delta: float):
	Game.event_manager.change_lucidity(-wash_power*delta)

func interact() -> void:
	if Game.event_manager.interactable_object is Water:
		if Game.event_manager.interactable_object.is_always_active: return
		is_washing = true
	if Game.event_manager.interactable_object is Poem and Game.event_manager.interactable_object.destroyable:
		parent.poem_collected += 1
		Game.event_manager.interactable_object.collect()
	if Game.event_manager.interactable_object is Lever:
		Game.event_manager.interactable_object.activate()
