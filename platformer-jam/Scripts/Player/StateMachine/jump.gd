extends State

@export var idle: State
@export var run: State
@export var fall: State
@export var double_jump: State
@export var jump_force: float = 500.0


func enter():
	super()
	parent.velocity.y = -jump_force
	parent.has_jumped = true
	Game.player.sprite.play("jump")
	$"../../Sounds/jump".play()
	

func process_inputs(event):
	if Input.is_action_just_released("Jump"):
		return fall
func process_physics(delta):
	if not Input.is_action_pressed("Jump"):
		return fall
	parent.velocity.y += gravity * delta
	
	var direction = Input.get_axis("Left", "Right")
	var movement = move_toward(parent.velocity.x, direction * move_speed, acceleration * delta)

	
	
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall
	
	if parent.is_on_floor():
		if movement != 0:
			return run
		return idle
	return null
