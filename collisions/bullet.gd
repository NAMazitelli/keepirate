extends KinematicBody2D

var _gravity = 0
var _movement = Vector2()
var bounce = 0.6
func shoot(directional_force, gravity):
	_movement = directional_force
	_gravity =  gravity
	set_physics_process(true)

func _physics_process(delta):
	_movement.y += delta * _gravity 
	var collision_info = move_and_collide(_movement) 
	if (collision_info):
		var motion = collision_info.remainder.bounce(collision_info.normal)
		_movement = _movement.bounce(collision_info.normal) * bounce
		move_and_collide(motion * bounce)
	else:
		move_and_collide(_movement) 


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()