extends Node2D

export (int) var distance_to_goal
export (int) var max_speed
export (int) var max_energy

var current_distance = 0
var speed_damp = 2
onready var current_speed = max_speed setget set_speed
onready var current_energy = max_energy setget set_energy

func _process(delta):
	current_distance += current_speed * delta 
	current_speed -= speed_damp * delta 
	
	if (current_speed > 0):
		current_energy -= current_speed * delta 
	if (current_energy <= 0):
		current_speed = 0
		
func set_speed(value):
	current_speed = clamp(value, 0, max_speed)
	
func set_energy(value):
	current_energy = clamp(value, 0, max_energy)