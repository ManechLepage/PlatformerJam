extends Node

@export var sound_layers : Dictionary[String,AudioStreamPlayer]
@export var sound_lib: Array[AudioStream]

var bridge_tween: Tween
var bridge_tween_value := 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.event_manager.lucidity_changed.connect(update_vol)
	Game.audio_manager = self
	set_bridge_effects(0)
	$"../Areas/BridgeArea1".body_entered.connect(func (_body): set_bridge(1))
	$"../Areas/BridgeArea1".body_exited.connect(func (_body): set_bridge(0))
	$"../Areas/BridgeArea2".body_entered.connect(func (_body): set_bridge(1))
	$"../Areas/BridgeArea2".body_exited.connect(func (_body): set_bridge(0))
	$"../Areas/End".body_entered.connect(func (_body): set_bridge(1))
	$"../Areas/End".body_exited.connect(func (_body): set_bridge(0))
	play_at_corrrect_time()
	
func set_noise_level(linear):
	sound_layers["noise"].volume_linear = linear

func clear_audio():
	sound_layers["base"].stream = null
	sound_layers["lucid_1"].stream = null
	sound_layers["lucid_2"].stream = null
	sound_layers["lucid_3"].stream = null
	sound_layers["lucid_4"].stream = null
	play_at_corrrect_time()
	
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

func set_bridge(val: float):
	if bridge_tween: bridge_tween.kill()
	bridge_tween = create_tween()
	bridge_tween.tween_method(set_bridge_effects,bridge_tween_value,val,2)

func set_bridge_effects(val):
	bridge_tween_value = val
	var rev : AudioEffectReverb = AudioServer.get_bus_effect(2,0)
	var lowpass : AudioEffectLowPassFilter = AudioServer.get_bus_effect(2,1)
	rev.wet = float(val)/5
	rev.dry = 1-val
	lowpass.cutoff_hz = remap(val,0,1,20500,1000)

func update_vol(lucidity):
	var ease_vol = func (x): return ease(x,0.3)
	sound_layers["lucid_1"].volume_linear = ease_vol.call(clamp(lucidity,0,20)/20)
	sound_layers["lucid_2"].volume_linear = ease_vol.call(clamp(lucidity-20,0,20)/20)
	sound_layers["lucid_3"].volume_linear = ease_vol.call(clamp(lucidity-40,0,20)/20)
	sound_layers["lucid_4"].volume_linear = ease_vol.call(clamp(lucidity-60,0,20)/20)
