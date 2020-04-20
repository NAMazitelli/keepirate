extends Node2D

export (PackedScene) var enemy_scene
export (NodePath) var enemy_objective_path
export (float) var spawn_timer = 3.0
export (float) var waited_time = 0.0
export (Array, NodePath) var spawn_list
export (Array, NodePath) var obj_list
onready var enemy_objective = .get_node(enemy_objective_path)
func _process(delta):
	waited_time+=delta
	if waited_time > spawn_timer:
		spawn_enemy()
		waited_time = 0
		
func spawn_enemy():
	var enemy = enemy_scene.instance()
	randomize()
	var spawn_index = randi() % spawn_list.size()
	if (spawn_index > 1):
		enemy.scale.x = -1
	
	enemy.enemy_objective =  get_node(obj_list[spawn_index]).get_path()
	enemy.position = get_node(spawn_list[spawn_index]).position
	get_parent().add_child(enemy)