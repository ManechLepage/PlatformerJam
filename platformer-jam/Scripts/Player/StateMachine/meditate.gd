extends State

@export var meditation_power: float

@export var idle: State
@export var fall: State
@export var meditate_running: State
var meditate_tween: PropertyTweener

func enter():
	super()
	Game.start_meditation_animation()
	parent.is_meditating = true
	Game.player.sprite.play("meditation_idle")
	if $"../../Sounds/meditate".volume_linear == 0: $"../../Sounds/meditate".play()
	if meditate_tween: meditate_tween.finished.emit()
	meditate_tween = create_tween().tween_property($"../../Sounds/meditate","volume_linear",1,0.5).set_ease(Tween.EASE_IN)

func exit():
	super()
	parent.is_meditating = false
	Game.clear_shake()

func process_inputs(event):
	if Input.is_action_just_released("Meditate"):
		Game.player.sprite.play("meditation_idle",-1)
		meditate_tween = create_tween().tween_property($"../../Sounds/meditate","volume_linear",0,1).set_ease(Tween.EASE_OUT)
		return idle
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		meditate_tween = create_tween().tween_property($"../../Sounds/meditate","volume_linear",0,0.5).set_ease(Tween.EASE_OUT)
		return meditate_running
	return null

	

func process_physics(delta):
	Game.event_manager.change_lucidity(meditation_power*delta)
	
	parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if Input.get_axis("Left", "Right") != 0:
		return meditate_running
	
	return null
