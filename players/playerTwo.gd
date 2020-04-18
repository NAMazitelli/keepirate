extends basePlayer
var direction = Vector2(0,0)
var dir_left = 0.0
var dir_right = 0.0

func _physics_process(delta):
	dir_left = Input.get_action_strength("p2_move_right")
	dir_right = Input.get_action_strength("p2_move_left")

	direction = Vector2(
		dir_left - dir_right,
		1.0
	)

	velocity = speed * direction
	velocity = move_and_slide(velocity)
