extends KinematicBody2D

export (NodePath) var enemy_objective

var hover_time = 0.5
var waited_time = 0
var direction = Vector2(0, 1)
var changing = false
var speed = 80
var health = 1 setget set_health

func _physics_process(delta):
	waited_time += delta
	
	if waited_time >= hover_time && !changing:
		changing = true
		change_direction_once()
		waited_time = 0

	var objective = get_node(enemy_objective)
	var obj_direction = (objective.position - position).normalized() + direction
	var motion = obj_direction * speed * delta
	position += motion
	if (health == 0):
		queue_free()
	

func change_direction_once():
	direction.y *= -1
	changing = false
	
func set_health(value):
	health = value