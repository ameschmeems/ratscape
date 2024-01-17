class_name Teleporter
extends Area2D

signal teleported(receiver_pos: Vector2)

@export var receiver: Area2D

func _ready():
	area_entered.connect(on_area_entered)

func on_area_entered(_area: Area2D):
	teleported.emit(receiver.global_position)
