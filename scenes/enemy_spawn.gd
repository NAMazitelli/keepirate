extends Node2D

export (PackedScene) var enemy_scene

var spawn_timer = 4.0
var waited_time = 0.0
onready var enemy_objective = get_parent().get_node("enemy_objective")
func _process(delta):
	waited_time+=delta
	if waited_time > spawn_timer:
		spawn_enemy()
		waited_time = 0
		
func spawn_enemy():
	var enemy = enemy_scene.instance()
	enemy.enemy_objective = enemy_objective.get_path()
	enemy.position = position
	get_parent().add_child(enemy)