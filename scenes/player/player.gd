extends Area2D

@export var teleporters: Array[Teleporter]
@export var directionals: Array[DirectionalPad]

@onready var decay_scene: PackedScene = preload("res://scenes/decay/decay.tscn")
@onready var ray: RayCast2D = $RayCast2D

var tile_size = 16
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var moving = false

func _ready():
	if teleporters:
		for teleporter in teleporters:
			teleporter.teleported.connect(on_teleported)
	if directionals:
		for directional in directionals:
			directional.launched.connect(on_launched)
	global_position = global_position.snapped(Vector2.ONE * tile_size)
	global_position += Vector2.ONE * tile_size / 2.0

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func _unhandled_input(event):
	for dir in inputs.keys():
		if !moving && event.is_action_pressed(dir):
			move(dir)

func move(dir) -> bool:
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		var old_global_position = global_position
		global_position += inputs[dir] * tile_size
		var decay_instance = decay_scene.instantiate()
		decay_instance.global_position = old_global_position
		get_node("/root/Main").call_deferred("add_child", decay_instance)
	return !ray.is_colliding()

func transport(pos: Vector2):
	var old_global_position = global_position
	global_position = pos
	var decay_instance = decay_scene.instantiate()
	decay_instance.global_position = old_global_position
	get_node("/root/Main").call_deferred("add_child", decay_instance)

func on_teleported(pos: Vector2):
	transport(pos)

func on_launched(dir: String):
	var valid = true
	moving = true
	while (valid):
		valid = move(dir)
		await get_tree().create_timer(0.2).timeout
	moving = false
