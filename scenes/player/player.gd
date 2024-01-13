extends CharacterBody2D

@export var movement_speed = 300
@onready var bite = $Bite

func _physics_process(_delta):
	var movement_x = Input.get_axis("move_left", "move_right")
	var movement_y = Input.get_axis("move_up", "move_down")

	rotation = deg_to_rad(-movement_x * 90)
	# rotate(deg_to_rad(movement_x * 90 + movement_y * 180))
	print(movement_x * 90)
	print(movement_y * 180)

	if Input.is_action_just_pressed("attack"):
		bite.attack()

	velocity = Vector2(movement_x, movement_y).normalized() * movement_speed
	move_and_slide()
