extends Node2D

export (int) var distance_to_goal
export (int) var max_speed
export (int) var max_energy

var current_distance = 0
var speed_damp = 2
var attacking = 0
var attack_damage = 20
var loose_time = 5.0
var death_timer = 0.0

onready var current_speed = max_speed setget set_speed
onready var current_energy = max_energy setget set_energy

func _process(delta):
	current_distance += current_speed * delta 
	set_speed(current_speed - speed_damp * delta)
	
	if (current_speed > 0):
		set_energy(current_energy -current_speed * delta)
	if (current_energy <= 0):
		set_speed(0)
		death_timer += delta
	else:
		death_timer = 0

	
	if (death_timer >= loose_time):
		game_over()
		
	current_energy -= (attacking * attack_damage) * delta
	if current_distance >= distance_to_goal:
		win_game()
		
func set_speed(value):
	current_speed = clamp(value, 0, max_speed)
	
func set_energy(value):
	current_energy = clamp(value, 0, max_energy)

func _on_enemy_objective_enemy_entered():
	attacking +=1

func win_game():
	get_tree().change_scene("res://scenes/inicio.tscn")
	print("you win")
	pass

func game_over():
	get_tree().change_scene("res://scenes/inicio.tscn")
	print("game over!")
	pass
