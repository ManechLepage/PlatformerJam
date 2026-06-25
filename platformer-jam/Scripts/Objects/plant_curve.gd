extends Line2D

@export var grad: Gradient
@export var progress := 1.0
@export var sample_count := 1.0
@export var texture_base: Texture
@export var has_hitbox: bool = false
@export var hitbox_scene: PackedScene
@export var hitbox_size: float
var follows := []

@onready var path := $Path2D

var global_pos: Vector2

func _ready():
	global_pos = global_position
	
	gradient = Gradient.new()
	for i in 10*sample_count:
		var new_follow = PathFollow2D.new()
		path.add_child(new_follow)
		new_follow.progress_ratio = float(i*0.02/sample_count)
		follows.append(new_follow)
		
		if has_hitbox:
			var hitbox: VineHitbox = hitbox_scene.instantiate()
			new_follow.add_child(hitbox)
			var rect = CircleShape2D.new()
			rect.radius =  hitbox_size*ease(1-(i/(10*sample_count)),0.2)
			hitbox.collision_shape_2d.shape = rect


func _process(delta):
	#print(progress)
	clear_points()
	for i in range(len(follows)):
		follows[i].progress_ratio = ease(float(i)/len(follows),0.8)*progress
		add_point(follows[i].global_position - global_pos)
	
	gradient.set_color(0, grad.sample(follows[0].progress_ratio))
	gradient.set_color(1, grad.sample(follows[-1].progress_ratio))
