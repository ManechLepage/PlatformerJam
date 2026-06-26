extends Node2D
@onready var Area: Area2D = $Area

@export var poem_text: RichTextLabel
@export var particles: CPUParticles2D
@export var sprite: AnimatedSprite2D
var progress: float = 0.0
var transparency: float = 0.0
var activated: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Area.area_entered.connect(_on_body_entered)
	Area.area_exited.connect(_on_body_exited)
	Game.event_manager.lucidity_changed.connect(update_particles)
	poem_text.modulate.a = 0
	
func update_particles(_value):
	Area.get_child(0).disabled = sprite.frame == 0
	particles.emitting = not sprite.frame == 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if activated:
		progress += delta
		poem_text.visible_characters = int(progress*20)
		if poem_text.modulate.a < 1:
			poem_text.modulate.a += delta*3
	else: 
		if poem_text.modulate.a > 0:
			poem_text.modulate.a -= delta*3

func _on_body_entered(body):
	if body== Game.player.interact_area:
		activated = true
		
func _on_body_exited(body):
	if body== Game.player.interact_area:
		activated = false
