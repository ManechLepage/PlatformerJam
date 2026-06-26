extends AnimationPlayer

@export var lever_index: int

func _ready() -> void:
	play_anim(not Game.lever_states[lever_index])

func _process(delta: float) -> void:
	if is_playing():
		Game.event_manager.lucidity_changed.emit(Game.lucidity)

func _on_lever_on_activated() -> void:
	play_anim(Game.lever_states[lever_index])
	Game.lever_states[lever_index] = not Game.lever_states[lever_index]

func play_anim(value: bool) -> void:
	if value: play_backwards("LeverAnim")
	else: play("LeverAnim")
	print(value)
