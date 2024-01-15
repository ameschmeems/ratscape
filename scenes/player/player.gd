extends Area2D


@onready var decay_scene: PackedScene = preload("res://scenes/decay/decay.tscn")
@onready var ray: RayCast2D = $RayCast2D

var tile_size = 16
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func _ready():
	global_position = global_position.snapped(Vector2.ONE * tile_size)
	global_position += Vector2.ONE * tile_size / 2.0

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		var old_global_position = global_position
		global_position += inputs[dir] * tile_size
		var decay_instance = decay_scene.instantiate()
		decay_instance.global_position = old_global_position
		get_node("/root/Main").add_child(decay_instance)
