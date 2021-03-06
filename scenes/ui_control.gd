extends Control
onready var main = get_parent()
onready var speed_percent 
var energy_bar 
var speed_needle
var needle_rotation setget set_needle_rotation

func _ready():
	energy_bar = get_node("speed/energy_bar")
	speed_needle = get_node("speed/flecha")
	energy_bar.max_value = main.max_energy

func _process(delta):
	energy_bar.value = main.current_energy
	speed_percent = main.current_speed * 100 / main.max_speed
	set_needle_rotation((speed_percent * 167 / 100) - 157)
	speed_needle.rotation_degrees = needle_rotation
	
func set_needle_rotation(value):
	needle_rotation = clamp(value, -157, 10)
	