extends Control
onready var main = get_parent().get_parent()
onready var speed_percent 
var energy_bar 
var speed_needle
var needle_rotation setget set_needle_rotation
var progreso 
var progress_percent
var progress_position setget set_progress_position

func _ready():
	energy_bar = get_node("energy/energy_bar")
	speed_needle = get_node("speed/flecha")
	progreso = get_node("progress_tip/progreso")
	energy_bar.max_value = main.max_energy
	
	
# 770 1180
func _process(delta):
	energy_bar.value = main.current_energy
	calculate_needle_rotation()
	calculate_progress()
	
func set_needle_rotation(value):
	needle_rotation = clamp(value, -157, 10)
	
func set_progress_position(value):
	progress_position = value
	
func calculate_progress():
	progress_percent = main.current_distance * 100 / main.distance_to_goal
	set_progress_position((progress_percent * 500 / 100))
	progreso.rect_position.x = progress_position
	
func calculate_needle_rotation():
	speed_percent = main.current_speed * 100 / main.max_speed
	set_needle_rotation((speed_percent * 167 / 100) - 157)
	speed_needle.rotation_degrees = needle_rotation