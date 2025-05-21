# GameOverScreen.gd
extends Control

@onready var current_score_label = %CurrentScoreLabel
@onready var high_score_label = %HighScoreLabel
@onready var retry_button = %RetryButton
@onready var main_menu_button = %MainMenuButton

func _ready():
	#retry_button.pressed.connect(_on_RetryButton_pressed)
	main_menu_button.pressed.connect(_on_MainMenuButton_pressed)

	# Mostrar el puntaje actual y el high score
	#current_score_label.text = "Score: %d" % GameManager.current_score
	#high_score_label.text = "High Score: %d" % SaveLoadManager.get_high_score()

	#AudioManager.play_sfx("game_over_sound") # Un sonido de game over

#func _on_RetryButton_pressed():
	#AudioManager.play_sfx("button_click")
	#GameManager.start_game()

func _on_MainMenuButton_pressed():
	#AudioManager.play_sfx("button_click")
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
