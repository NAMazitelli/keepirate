extends Node2D

export (PackedScene) var enemy_scene
export (NodePath) var enemy_objective_path
export (float) var spawn_timer = 5.0

export (float) var waited_time = 0.0
onready var enemy_objective = .get_node(enemy_objective_path)
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