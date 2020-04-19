extends basePlayer
var direction = Vector2(0,0)


func _physics_process(delta):
	direction = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity)
	
func get_direction():
	return Vector2(
		Input.get_action_strength("p1_move_right") - Input.get_action_strength("p1_move_left"),
		1.0
	)
