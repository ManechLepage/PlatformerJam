extends AudioStreamPlayer
@export var meditation_state : State



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.player.state_machine.current_state == meditation_state:
		if volume_linear == 0: play()
		volume_linear = clampf(volume_linear+delta*2,0,1)
	else:
		volume_linear = clampf(volume_linear-delta,0,1)
