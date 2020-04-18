extends KinematicBody2D
class_name movableActor
var speed = Vector2(300, 1000)
var velocity = Vector2.ZERO
var gravity = 500.0

func _physics_process(delta):
	velocity.y += gravity * delta
