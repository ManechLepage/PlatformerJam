extends Line2D

@export var grad: Gradient
@export var progress := 1.0
@export var sample_count := 1.0
@export var texture_base: Texture
@export var has_hitbox: bool = false
@export var hitbox_scene: PackedScene
var follows := []

@onready var path := $Path2D

func _ready():
	gradient = Gradient.new()
	for i in 10*sample_count:
		var new_follow = PathFollow2D.new()
		path.add_child(new_follow)
		new_follow.progress_ratio = float(i*0.02/sample_count)
		follows.append(new_follow)
		var sprite = Sprite2D.new()
		new_follow.add_child(sprite)
		sprite.texture = texture_base
		sprite.scale = Vector2.ONE * ease(1-(i/(10*sample_count)),0.2)
		
		if not has_hitbox: return
		var hitbox: VineHitbox = hitbox_scene.instantiate()
		sprite.add_child(hitbox)
		var rect: Rect2 = sprite.get_rect()
		hitbox.load_hitbox(rect)


func _process(delta):
	#print(progress)
	clear_points()
	for i in range(len(follows)):
		follows[i].progress_ratio = ease(float(i)/len(follows),0.7)*progress
		add_point(follows[i].global_position)
	
	gradient.colors[0] = grad.sample(follows[0].progress_ratio)
	gradient.colors[1] = grad.sample(follows[-1].progress_ratio)
