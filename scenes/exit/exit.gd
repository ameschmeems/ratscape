extends Area2D

@export var player_pos: Array[Vector2]

@onready var player_scene: PackedScene = preload("res://scenes/player/player.tscn")

var current_player: int = 0

func _ready():
	self.area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D):
	current_player += 1
	print(current_player)
	if current_player == 3:
		get_tree().reload_current_scene()
		return
	area.queue_free()
	var new_player = player_scene.instantiate()
	new_player.set_deferred("global_position", player_pos[current_player])
	get_node("/root/Main").call_deferred("add_child", new_player)
