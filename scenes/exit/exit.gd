extends Area2D

@export var player_pos: Array[Vector2]
@export var teleporters: Array[Teleporter]
@export var next_level: PackedScene

@onready var player_scene: PackedScene = preload("res://scenes/player/player.tscn")

var current_player: int = 0

func _ready():
	self.area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D):
	current_player += 1
	if current_player == 3:
		if !next_level:
			get_tree().quit()
			return
		get_tree().change_scene_to_packed(next_level)
		return
	area.queue_free()
	var new_player = player_scene.instantiate()
	new_player.teleporters = teleporters
	new_player.set_deferred("global_position", player_pos[current_player])
	get_parent().call_deferred("add_child", new_player)
