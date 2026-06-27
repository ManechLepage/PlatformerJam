extends ColorRect

func _process(delta: float) -> void:
	get_material().set_shader_parameter(
		"vignette_strength", 
		lerpf(
			get_material().get_shader_parameter("vignette_strength"), 
			lerpf(
				0.0, 
				13.0,
				float(Game.player.is_meditating) * (Game.lucidity * 0.009 + 0.1)
				), 
			5.0 * delta
			)
	)
