extends Area2D

@export var door: StaticBody2D

func _ready():
	area_entered.connect(on_area_entered)

func on_area_entered(_area: Area2D):
	door.queue_free()
