extends basePlayer
var direction = Vector2(0,0)
var animation

func _ready():
	animation = get_node("frames/AnimationPlayer")
	
func _physics_process(delta):
	direction = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity)
	
func get_direction():
	var movement = Input.get_action_strength("p1_move_right") - Input.get_action_strength("p1_move_left")
	if movement != 0:
		animation.play("walk")
	else:
		animation.seek(0, true)
		animation.stop(true)
		
	return Vector2(
 		movement,
		1.0
	)
