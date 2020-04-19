extends Node2D
onready var ola1 = get_node('ola-arriba-01/waveanim')
onready var ola2 = get_node('ola-arriba-02/waveanim')
func _ready():
	ola1.play("wave")
	ola2.play("wave")
	pass # Replace with function body.
