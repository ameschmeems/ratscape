class_name DirectionalPad
extends Area2D

@export var dir: String

signal launched(dir: String)

func _ready():
	area_entered.connect(on_area_entered)

func on_area_entered(_area: Area2D):
	launched.emit(dir)
