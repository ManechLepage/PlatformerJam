extends AnimationPlayer

var switched = false

func _process(delta: float) -> void:
	if is_playing():
		Game.event_manager.lucidity_changed.emit(Game.lucidity)

func _on_lever_on_activated() -> void:

	if switched: play_backwards("LeverAnim")
	else: play("LeverAnim")
	switched = not switched
