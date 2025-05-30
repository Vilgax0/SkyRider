extends Control
@onready var background_animated_sprite = $animationstart

func _ready():
	
	if background_animated_sprite:
		background_animated_sprite.play("idle") # Reproduce la animación "idle" al inicio
		print("Main Menu: Animación 'idle' del fondo iniciada.") # Debug
	else:
		print("Main Menu: ¡ADVERTENCIA! No se encontró el AnimatedSprite2D para el fondo. Revisa la ruta.") # Debug
	
	
	var check_button = get_node_or_null("CheckButton") 
	if check_button:
		check_button.pressed.connect(_on_check_button_pressed_mute)
	else:
		print("Main Menu: Mute button not found. Check the node path.")
	
func _on_play_pressed() -> void:
	GameManager.start_game()
	


func _on_design_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level/design.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_check_button_pressed_mute() -> void:
	
	var is_muted = AudioManager.toggle_mute()
	print("Audio: Music mute toggled. Muted: ", is_muted) # Debug
