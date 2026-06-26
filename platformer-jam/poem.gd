class_name Poem
extends Area2D
@export var poem_text: RichTextLabel
var has_been_found: bool = false
@export var destroyable: bool = true
var progress: float = 0.0
var transparency: float = 0.0
var activated: bool = false
var collecting: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	poem_text.modulate.a = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if activated:
		progress += delta
		poem_text.visible_characters = int(progress*20)
		if poem_text.modulate.a < 1:
			poem_text.modulate.a += delta*3
		if poem_text.visible_characters >= len(poem_text.text):
			Game.event_manager.interactable_object = self

	else: 
		if poem_text.modulate.a > 0 and not collecting:
			poem_text.modulate.a -= delta*3

		
func _on_area_entered(body):
	if body == Game.player.interact_area:
		activated = true
		
		
		
func _on_area_exited(body):
	if body == Game.player.interact_area:
		activated = false
		Game.event_manager.interactable_object = null
		
func collect():
	if destroyable:
		monitoring = false
		collecting = true
		create_tween().tween_property(self, "modulate", Color(5, 5, 5, 0), 2)
