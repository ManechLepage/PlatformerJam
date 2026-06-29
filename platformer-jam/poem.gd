class_name Poem
extends Area2D
@export var poem_text: RichTextLabel

@onready var image: TextureRect = $CanvasLayer/TextureRect2
@onready var bg: TextureRect = $CanvasLayer/TextureRect
@export var destroyable: bool = true
var progress: float = 0.0
var transparency: float = 0.0
var activated: bool = false
var collecting: bool = false
var upgrade_text: int = 0
var end_seq := false
@export var poem_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Game.poems_found[poem_index] and poem_index != 5 :
		monitorable = false
		monitoring = false
		hide()
	if name == "end_tutorial": Game.end_popup = self
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	poem_text.modulate.a = 0
	image.modulate.a = 0
	bg.modulate.a = 0
	upgrade_text = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if upgrade_text >0:
		modulate.a = 0
		poem_text.modulate.a = 0
		image.modulate.a = 0
		progress += delta
		$CanvasLayer/upgrade.visible_characters = int(progress*40)
		if upgrade_text == 1 and Input.is_action_just_pressed("Interact"):
		#and $CanvasLayer/upgrade.visible_characters >= len($CanvasLayer/upgrade.text):
			next_2()
	elif not collecting:
		if activated:
			progress += delta
			poem_text.visible_characters = int(progress*150)
			if poem_text.modulate.a < 1:
				poem_text.modulate.a += min(delta*3,1)
				image.modulate.a += min(delta*3,1)
				bg.modulate.a += min(delta*3,1)
				
			if poem_text.visible_characters >= len(poem_text.text):
				Game.event_manager.interactable_object = self

		else: 
			if poem_text.modulate.a > 0 and not collecting:
				poem_text.modulate.a -= max(delta*3,0)
				image.modulate.a -= max(delta*3,0)
				bg.modulate.a -= max(delta*3,0)
	
		
func _on_area_entered(body):
	if body == Game.player.interact_area:
		activated = true
		
		
		
func _on_area_exited(body):
	if body == Game.player.interact_area:
		activated = false
		Game.event_manager.interactable_object = null
		
func collect():
	if destroyable and activated and poem_text.visible_characters >= len(poem_text.text):
		monitoring = false
		collecting = true
		create_tween().tween_property(self, "modulate", Color(5, 5, 5, 1), 2)
		create_tween().tween_property(poem_text, "modulate", Color(5, 5, 5, 1), 2)
		create_tween().tween_property(image, "modulate", Color(5, 5, 5, 0), 2)
		create_tween().tween_property(bg, "modulate", Color(1, 1, 1, 2), 2)
		create_tween().tween_property(AudioServer.get_bus_effect(2,2), "volume_linear", 0, 2)
		get_tree().create_timer(2.5).timeout.connect(next)
		if name != "END":Game.player.process_mode = Node.PROCESS_MODE_DISABLED

		
func next():
	modulate.a = 0
	poem_text.modulate.a = 0
	image.modulate.a = 0
	progress = 0
	upgrade_text = 1

func next_2():
	Game.poems_found[poem_index] = true
	upgrade_text = 2
	create_tween().tween_property(bg, "modulate", Color(5, 5, 5, 0), 2)
	create_tween().tween_property($CanvasLayer/upgrade, "modulate", Color(1, 1, 1, 0), 2)
	create_tween().tween_property(AudioServer.get_bus_effect(2,2), "volume_linear", 1, 2)
	Game.player.process_mode = Node.PROCESS_MODE_INHERIT
	Game.max_lucidity += 20
	print(Game.max_lucidity)
	if Game.max_lucidity == 100 and $"../end_tutorial/CollisionShape2D":
		Game.audio_manager.clear_audio()
		get_tree().create_timer(3.5).timeout.connect(func(): $"../end_tutorial/CollisionShape2D".disabled = false)
	
