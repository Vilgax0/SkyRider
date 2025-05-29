extends Control


func _on_play_pressed() -> void:
	GameManager.start_game()
	# ¡Elimina la línea de get_tree().change_scene_to_file() de aquí!
	get_tree().change_scene_to_file("res://Scenes/level/level1.tscn")


func _on_design_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level/design.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_check_button_pressed_mute() -> void:
	# Para mutear/desmutear, es mejor usar AudioServer.set_bus_mute()
	# Esto afectará a todos los sonidos en el bus "Master" (o el que elijas).
	var master_bus_index = AudioServer.get_bus_index("Master")
	var is_muted = AudioServer.is_bus_mute(master_bus_index)
	AudioServer.set_bus_mute(master_bus_index, not is_muted)
	print("Audio: Master bus mute toggled. Muted: ", not is_muted) # Debug
