extends Node2D
signal enemy_entered

func _on_Area2D_body_entered(body):
	emit_signal("enemy_entered")
	body.attacking = true
