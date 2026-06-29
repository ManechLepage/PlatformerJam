extends State

@export var wash_power = 0.02
@export var idle: State




func enter():
	super()
	if Game.player.wash_area.get_overlapping_areas():
		Game.player.sprite.play("wash")
		Game.player.is_washing = true
	else: 
		for i in Game.player.interact_area.get_overlapping_areas():
			if i is Poem:
				i.collect()
			elif i is Lever:
				i.activate()
			return idle
	

func exit():
	super()

func process_inputs(event):
	if Input.is_action_just_released("Interact"):
		Game.player.is_washing = false
		return idle
	return null

func process_physics(delta):
	if not Game.player.wash_area.get_overlapping_areas():
		Game.player.is_washing = false
		return idle


	
