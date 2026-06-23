extends State

@export var jump: State
@export var run: State
@export var fall: State
@export var meditate_idle: State
@export var interact: State

func enter():
	super()
	if (Game.player.sprite.animation == "running" and Game.player.sprite.frame > 1
	or Game.player.sprite.animation == "meditation_idle"):
		Game.player.sprite.animation_looped.connect(idle_on_loop_finished)
	else: Game.player.sprite.play("idle")
	
func idle_on_loop_finished(): Game.player.sprite.play("idle")
func exit():
	if Game.player.sprite.animation_looped.is_connected(idle_on_loop_finished):
		Game.player.sprite.animation_looped.disconnect(idle_on_loop_finished)

func process_inputs(event):
	if Input.is_action_just_pressed("Meditate"):
		return meditate_idle
	if Input.is_action_just_pressed("Interact"):
		return interact
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return run
	return null

func process_physics(delta):
	parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if Input.get_axis("Left", "Right") != 0:
		return run
	
	return null
