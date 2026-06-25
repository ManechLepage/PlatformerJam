extends Node

@export var sound_layers : Dictionary[String,AudioStreamPlayer]
@export var sound_lib: Array[AudioStream]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_pillar_3()
	Game.event_manager.lucidity_changed.connect(update_vol)
#func clear_sound():
	#
func play_at_corrrect_time():
	var time = sound_layers["noise"].get_playback_position()
	for i in ["base","lucid_1","lucid_2","lucid_3","lucid_4"]:
		sound_layers[i].play(time)

func set_pillar_1():
	sound_layers["base"].stream = sound_lib[1]
	sound_layers["lucid_1"].stream = sound_lib[2]
	sound_layers["lucid_2"].stream = sound_lib[3]
	sound_layers["lucid_3"].stream = sound_lib[4]
	sound_layers["lucid_4"].stream = null
	play_at_corrrect_time()

func set_pillar_2():
	sound_layers["base"].stream = sound_lib[5]
	sound_layers["lucid_1"].stream = sound_lib[6]
	sound_layers["lucid_2"].stream = sound_lib[7]
	sound_layers["lucid_3"].stream = null
	sound_layers["lucid_4"].stream = null
	play_at_corrrect_time()

func set_pillar_3():
	sound_layers["base"].stream = sound_lib[8]
	sound_layers["lucid_1"].stream = sound_lib[9]
	sound_layers["lucid_2"].stream = sound_lib[10]
	sound_layers["lucid_3"].stream = sound_lib[11]
	sound_layers["lucid_4"].stream = null
	play_at_corrrect_time()

func update_vol(lucidity):
	var ease_vol = func (x): return ease(x,0.3)
	sound_layers["lucid_1"].volume_linear = ease_vol.call(clamp(lucidity,0,20)/20)
	sound_layers["lucid_2"].volume_linear = ease_vol.call(clamp(lucidity-20,0,20)/20)
	sound_layers["lucid_3"].volume_linear = ease_vol.call(clamp(lucidity-40,0,20)/20)
	sound_layers["lucid_4"].volume_linear = ease_vol.call(clamp(lucidity-60,0,20)/20)
