extends AnimationPlayer

func _ready() -> void:
	Game.event_manager.lucidity_changed.connect(set_animation)
	play("lucidity")

func set_animation(lucidity):
	seek(lucidity/100, true)
