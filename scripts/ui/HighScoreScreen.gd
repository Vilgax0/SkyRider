# HighScoreScreen.gd
extends Control

@onready var high_score_label = %HighScoreValueLabel # Etiqueta para mostrar el puntaje
@onready var back_button = %BackButton

func _ready():
	back_button.pressed.connect(_on_BackButton_pressed)
	high_score_label.text = str(SaveLoadManager.get_high_score()) # Muestra el puntaje

func _on_BackButton_pressed():
	AudioManager.play_sfx("button_click")
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
