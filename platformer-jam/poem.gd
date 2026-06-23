extends Node2D
@onready var Area: Area2D = $Area
@export var e_key: Sprite2D
@export var poem_text: RichTextLabel
var has_been_found: bool = false
var progress: float = 0.0
var transparency: float = 0.0
var activated: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Area.body_entered.connect(_on_body_entered)
	Area.body_exited.connect(_on_body_exited)
	poem_text.modulate.a = 0
	


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
	if body.name == "Player":
		activated = true
		
func _on_body_exited(body):
	if body.name == "Player":
		activated = false
