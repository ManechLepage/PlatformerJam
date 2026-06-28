extends AnimationPlayer

@export var lever_index: int

func _ready() -> void:
	if Game.lever_states[lever_index] : play_anim(true)

func _process(delta: float) -> void:
	if is_playing():
		Game.event_manager.lucidity_changed.emit(Game.lucidity)

func _on_lever_on_activated() -> void:
	play_anim(Game.lever_states[lever_index])
	Game.lever_states[lever_index] = not Game.lever_states[lever_index]

func play_anim(value: bool) -> void:
	if not value: play_backwards("LeverAnim")
	else: play("LeverAnim")
	print(value)
