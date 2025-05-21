# MainMenu.gd
extends Control

@onready var play_button = %PlayButton
@onready var high_score_button = %HighScoreButton
@onready var credits_button = %CreditsButton
@onready var quit_button = %QuitButton # Opcional para PC/Android, iOS no tiene botón de salir

func _ready():
	# Conectar señales de los botones a funciones locales
	play_button.pressed.connect(_on_PlayButton_pressed)
	high_score_button.pressed.connect(_on_HighScoreButton_pressed)
	credits_button.pressed.connect(_on_CreditsButton_pressed)
	if OS.get_name() != "iOS": # No mostrar botón de salir en iOS
		quit_button.pressed.connect(_on_QuitButton_pressed)
	else:
		quit_button.visible = false # Ocultar el botón

	#AudioManager.play_music("menu_music") # Asume que tienes una música de menú

func _on_PlayButton_pressed():
	AudioManager.play_sfx("button_click")
	GameManager.start_game()

func _on_HighScoreButton_pressed():
	AudioManager.play_sfx("button_click")
	get_tree().change_scene_to_file("res://scenes/ui/high_score_screen.tscn")

func _on_CreditsButton_pressed():
	AudioManager.play_sfx("button_click")
	get_tree().change_scene_to_file("res://scenes/ui/credits_screen.tscn")

func _on_QuitButton_pressed():
	AudioManager.play_sfx("button_click")
	get_tree().quit() # Sale de la aplicación
