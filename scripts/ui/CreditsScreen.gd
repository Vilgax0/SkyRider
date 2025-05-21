# CreditsScreen.gd
extends Control

@onready var back_button = %BackButton

func _ready():
	back_button.pressed.connect(_on_BackButton_pressed)

func _on_BackButton_pressed():
	AudioManager.play_sfx("button_click")
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
