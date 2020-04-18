extends movableActor
var hover_time = 3.0
var waited_time = 0
var direction = Vector2.UP

func _physic_process(delta):
	waited_time += delta
	if waited_time > hover_time:
		direction = -direction
	direction = move_and_slide(direction)

