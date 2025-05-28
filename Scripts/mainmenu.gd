extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level/level1.tscn")


func _on_design_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level/design.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_check_button_pressed_mute() -> void:
	get_tree().mute
