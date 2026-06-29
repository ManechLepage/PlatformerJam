extends State

@export var gravity_multiplier: float = 1.8

@onready var timer = $CoyoteJump
@onready var input_delay_timer = $InputDelay
@onready var min_time_for_flip: Timer = $MinTimeForFlip

@export var double_jump: State
@export var jump: State
@export var run: State
@export var idle: State

var can_control: bool = true
var will_flip: bool = false

func enter():
	Game.player.velocity.y = max(Game.player.velocity.y, -130) #quick release makes u instant fall
	timer.start()
	min_time_for_flip.start()
	will_flip = false
	super()
	if not (Game.player.sprite.animation in ["double_jump","running"]):
		Game.player.sprite.play("fall")

func exit():
	can_control = true

func process_inputs(event):
	if Input.is_action_just_pressed("Jump"):
		if Input.is_action_pressed("run"): return jump
		if timer.time_left > 0 and !parent.has_jumped:
			return jump
		
		elif Game.player.interact_area.get_overlapping_areas():
			return double_jump
		else:
			input_delay_timer.start()
	return null

func process_physics(delta):
	var movement = Input.get_axis("Left", "Right") * move_speed
	#flip_character(movement)
	
	parent.velocity.y += gravity * delta * gravity_multiplier
	parent.velocity.y = min(parent.velocity.y,max_fall_speed)
	if can_control:
		parent.velocity.x = movement
	parent.move_and_slide()
	
	if Game.player.sprite.animation == "jump" and parent.velocity.y >=0:
		Game.player.sprite.play("fall")
	
	if timer.is_stopped() and !parent.has_jumped and Game.player.sprite.animation == "running":
			Game.player.sprite.play("fall")
	
	if parent.is_on_floor():
		parent.has_jumped = false
		if input_delay_timer.time_left > 0:
			flip_character(movement)
			return jump
		if movement != 0:
			if will_flip:
				Game.player.sprite.play("roll", 2.0)
				parent.is_flipping_on_landing = true
			return run
		return idle
	elif input_delay_timer.time_left > 0 and Game.player.interact_area.get_overlapping_areas():
		return double_jump
	
	return null

func _on_min_time_for_flip_timeout() -> void:
	will_flip = true
