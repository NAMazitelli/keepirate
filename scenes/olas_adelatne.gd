extends Node2D

onready var waves = get_node("ola-abajo/wave")
onready var waves2 = get_node("ola-abajo2/wave")
func _ready():
	waves.play("wave")
	waves2.play("wave")