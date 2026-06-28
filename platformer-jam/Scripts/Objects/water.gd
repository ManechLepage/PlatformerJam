class_name Water
extends Area2D

@export var active: bool = true:
	set(value):
		active = value
		if active != value: active_changed(value)

@export var is_always_active = false
@export var sprite: AnimatedSprite2D

@export var poem_text: RichTextLabel

var progress: float = 0.0
var transparency: float = 0.0
var activated: bool = false

func _ready() -> void:
	active_changed(active)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func active_changed(value):
	if sprite: sprite.play("active" if value else "inactive")
	if $Parchemin: $Parchemin.emitting = active
	monitorable = value
	monitoring = value

func _process(delta: float) -> void:
	if activated:
		progress += delta
		poem_text.visible_characters = int(progress*20)
		if poem_text.modulate.a < 1:
			poem_text.modulate.a += delta*3
	elif poem_text:
		if poem_text.modulate.a > 0:
			poem_text.modulate.a -= delta*3

func _on_area_entered(body):
	if body == Game.player.wash_area:
		activated = true
		
func _on_area_exited(body):
	if body == Game.player.wash_area:
		activated = false
		Game.event_manager.interactable_object = null
