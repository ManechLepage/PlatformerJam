extends Node2D

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	if player:
		for layer: Parallax2D in get_children():
			layer.screen_offset = (player.global_position - global_position) * Game.lucidity/100
