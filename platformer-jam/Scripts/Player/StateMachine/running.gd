extends State

@export var jump: State
@export var idle: State
@export var fall: State
@export var meditate: State
@export var interact: State

@onready var state_machine: StateMachine = $".."

func enter():
	super()
	if not parent.is_flipping_on_landing: Game.player.sprite.play("running")

func exit():
	super()
	if not Game.player.sprite.animation == "roll" :parent.is_flipping_on_landing = false
	

func process_inputs(event):
	if Input.is_action_just_released("Interact"):
		return interact
	if Input.is_action_just_pressed("Meditate"):
		return meditate
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump

func process_physics(delta):
	var direction = Input.get_axis("Left", "Right")
	
	flip_character(direction)
	
	if direction != 0:
		parent.velocity.x = move_toward(parent.velocity.x, direction * move_speed*(3 if Input.is_action_pressed("run") else 1), acceleration * delta)
		
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if direction == 0:
		return idle
	if parent.velocity.y > 0:
		return fall

func _on_sprite_animation_looped() -> void:
	if state_machine.current_state == self:
		if parent.sprite.animation == "roll":
			parent.sprite.play("running")
			parent.is_flipping_on_landing = false
