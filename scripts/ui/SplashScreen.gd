# SplashScreen.gd
extends Control

@export var splash_display_time: float = 3.0 # Tiempo en segundos

func _ready():
	# Asegúrate de que el splash screen es el primero en cargarse.
	# Puedes añadir animaciones aquí si lo deseas.
	#AudioManager.play_music("splash_music") # Opcional: música de splash
	await get_tree().create_timer(splash_display_time).timeout
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
