extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.credits = self
	hide()

func start_credits():
	Game.end_popup.hide()
	Game.player.hide()
	show()
	modulate.a=0
	create_tween().tween_property(self,"modulate:a",1.,0)
	create_tween().tween_property(Game.world_env.environment,"adjustment_brightness",1.,5)
	create_tween().tween_method(Game.audio_manager.set_noise_level,0.,1.,5)
	
