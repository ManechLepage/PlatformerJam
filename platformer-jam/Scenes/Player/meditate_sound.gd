extends AudioStreamPlayer
@export var meditation_state : State
@export var meditation_end_state : State

var max_vol := 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.player.state_machine.current_state == meditation_state:
		if volume_linear == 0: play()
		volume_linear = clampf(volume_linear+delta*2,0,1)*max_vol
	elif(Game.player.state_machine.current_state == meditation_end_state and Input.is_action_pressed("Meditate")):
		volume_linear = clampf(volume_linear+delta*2,0,1)*max_vol
	else:
		volume_linear = clampf(volume_linear-delta,0,1)*max_vol
		
		
