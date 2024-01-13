extends Node2D

@onready var hitbox_shape: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var timer: Timer = $Timer

var attacking = false

func _ready():
	timer.timeout.connect(on_timer_timeout)

func attack():
	if !attacking:
		attacking = true
		hitbox_shape.disabled = false
		timer.start()

func on_timer_timeout():
	attacking = false
	hitbox_shape.disabled = true
