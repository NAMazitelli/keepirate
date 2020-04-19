extends Control
onready var main = get_parent()
var distance_bar 
var speed_bar 
var energy_bar 

func _ready():
	distance_bar = get_node("distance/distance_bar")
	energy_bar = get_node("speed/energy_bar")
	speed_bar = get_node("speed/speed_bar")
	
	distance_bar.max_value = main.distance_to_goal
	speed_bar.max_value = main.max_speed
	energy_bar.max_value = main.max_energy
	
func _process(delta):
	distance_bar.value = main.current_distance
	speed_bar.value = main.current_speed
	energy_bar.value = main.current_energy
	
