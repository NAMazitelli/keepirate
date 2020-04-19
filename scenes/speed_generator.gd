extends StaticBody2D
var enabled = false
var charging
var charge_delay = 0.3
var waited = 0

onready var main = get_parent()

func _input(event):
	if(enabled):
		if (event.is_action_pressed("ui_select")):
			charging = true
		elif (event.is_action_released("ui_select")):
			charging = false
			
func _process(delta):
	if (charging && waited > charge_delay):
		charge_once()
		waited = 0
	elif (waited <= charge_delay):
		waited += delta
		
func charge_once():
	main.set_speed(main.current_speed + 2)
	charging = false

func _on_Area2D_body_entered(body):
	enabled = true
	
func _on_Area2D_body_exited(body):
	enabled = false
