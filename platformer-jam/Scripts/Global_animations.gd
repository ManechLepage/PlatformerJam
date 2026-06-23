extends AnimationPlayer

func _ready() -> void:
	Game.event_manager.lucidity_changed.connect(set_animation)

func set_animation(lucidity):
	self.seek(lucidity/100, true)
