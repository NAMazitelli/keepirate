extends Control



func _on_Jugar_pressed():
	get_tree().change_scene("res://scenes/main.tscn")


func _on_Instrucciones_pressed():
	get_tree().change_scene("res://scenes/instructions.tscn")

func _on_Salir_pressed():
	get_tree().quit()
