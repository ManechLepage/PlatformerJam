extends AnimationPlayer

var switched = false

func _on_lever_on_activated() -> void:

	if switched: play_backwards("LeverAnim")
	else: play("LeverAnim")
	switched = not switched
