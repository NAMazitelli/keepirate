extends Node2D

export (int) var distance_to_goal
export (int) var max_speed
export (int) var max_energy

var current_distance = 0
var speed_damp = 5
var attacking = 0
var attack_damage = 15
var loose_time = 5.0
var death_timer = 0.0
onready var background_danger = get_node("background-danger")
onready var current_speed = max_speed setget set_speed
onready var current_energy = max_energy setget set_energy
var total_damage = 0
var danger = true
func _process(delta):
	current_distance += current_speed * delta
	set_speed(current_speed - speed_damp * delta)
	if attacking > 0:
		total_damage = (attacking * attack_damage) * delta

	if (current_speed > 0):
		set_energy((current_energy - current_speed / 100) - total_damage)
	else:
		set_energy(current_energy - total_damage)
		
	if (current_energy <= 0 && !danger):
		danger = true
		background_danger.show()
		set_speed(0)

	if danger :
		death_timer += delta
		if (current_energy > (max_energy * 10 / 100)):
			danger = false
			background_danger.hide()
			death_timer = 0
		if (death_timer >= loose_time):
			game_over()



	if current_distance >= distance_to_goal:
		win_game()

func set_speed(value):
	current_speed = clamp(value, 0, max_speed)

func set_energy(value):
	current_energy = clamp(value, 0, max_energy)



func win_game():
	get_tree().change_scene("res://scenes/win.tscn")

func game_over():
	get_tree().change_scene("res://scenes/youlose.tscn")


func _on_enemy_objective_enemy_entered():
	attacking +=1

func _on_enemy_objective4_enemy_entered():
	attacking +=1

func _on_enemy_objective3_enemy_entered():
	attacking +=1

func _on_enemy_objective2_enemy_entered():
	attacking +=1
