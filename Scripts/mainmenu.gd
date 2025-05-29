extends Control
@onready var background_animated_sprite = $animationstart

func _ready():
	# Verifica que el AnimatedSprite2D exista antes de intentar reproducir una animación
	if background_animated_sprite:
		background_animated_sprite.play("idle") # Reproduce la animación "idle" al inicio
		print("Main Menu: Animación 'idle' del fondo iniciada.") # Debug
	else:
		print("Main Menu: ¡ADVERTENCIA! No se encontró el AnimatedSprite2D para el fondo. Revisa la ruta.") # Debug
	
	# Asegúrate de que el botón de mute tenga la conexión correcta al AudioServer
	var check_button = $"Path/To/Your/CheckButton" # Reemplaza con la ruta real a tu CheckButton
	if check_button:
		check_button.pressed.connect(_on_check_button_pressed_mute)
	
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
