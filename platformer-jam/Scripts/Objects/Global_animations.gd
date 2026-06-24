extends AnimationPlayer

func _ready() -> void:
	Game.event_manager.lucidity_changed.connect(set_animation)
	play("Lucidity")
	await get_tree().create_timer(0.0).timeout
	set_animation(Game.lucidity)

func set_animation(lucidity):
	seek(lucidity/100, true)
