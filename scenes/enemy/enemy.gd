extends CharacterBody2D

@onready var vision_cone: Area2D = $VisionCone

func _ready():
	vision_cone.area_entered.connect(on_vision_cone_area_entered)

func on_vision_cone_area_entered(_area: Area2D):
	print("entered")
