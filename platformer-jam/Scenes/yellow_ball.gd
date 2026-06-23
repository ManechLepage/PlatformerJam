extends Node2D
@onready var Area: Area2D = $Area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Area.body_entered.connect(_on_body_entered)
	Area.body_exited.connect(_on_body_exited)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if body.name == "Player":
		pass
		
func _on_body_exited(body):
	if body.name == "Player":
		pass
