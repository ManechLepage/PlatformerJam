class_name Platform
extends AnimatableBody2D

@export var is_platform: bool = false

@onready var hitbox: CollisionShape2D = find_child("CollisionShape2D")

func _ready() -> void:
	if is_platform and hitbox:
		hitbox.one_way_collision = true
		hitbox.one_way_collision_margin = 5
	Game.event_manager.lucidity_changed.connect(change_lucidity)
	
func change_lucidity(val):
	if hitbox:
		hitbox.disabled = (global_scale <= Vector2.ONE *0.01) or (hitbox.global_scale <= Vector2.ONE *0.01)
		

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Down"):
		if not is_platform: return
		if hitbox: hitbox.disabled = true
	if Input.is_action_just_released("Down"):
		if not is_platform: return
		if hitbox: hitbox.disabled = false
