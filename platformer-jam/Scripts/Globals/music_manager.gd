extends Node

@export var sound_layers : Dictionary[String,AudioStreamPlayer]
@export var sound_lib: Array[AudioStream]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_pillar_1()
	Game.event_manager.lucidity_changed.connect(update_vol)
#func clear_sound():
	#

func set_pillar_1():
	var time = sound_layers["noise"].get_playback_position()
	sound_layers["base"].stream = sound_lib[1]
	sound_layers["base"].play(time)
	sound_layers["lucid_1"].stream = sound_lib[2]
	sound_layers["lucid_1"].play(time)

func update_vol(lucidity):
	var ease_vol = func (x): return ease(x,0.3)
	sound_layers["lucid_1"].volume_linear = ease_vol.call(clamp(lucidity,0,20)/20)
	sound_layers["lucid_2"].volume_linear = ease_vol.call(clamp(lucidity-20,0,20)/20)
	sound_layers["lucid_3"].volume_linear = ease_vol.call(clamp(lucidity-40,0,20)/20)
	sound_layers["lucid_4"].volume_linear = ease_vol.call(clamp(lucidity-60,0,20)/20)
