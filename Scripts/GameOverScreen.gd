# scripts/ui/GameOverScreen.gd
extends Control

@onready var final_score_label = $VBoxContainer/FinalScoreLabel
@onready var restart_button = $VBoxContainer/HBoxContainer/RestartButton
@onready var menu_button = $VBoxContainer/HBoxContainer/MenuButton

func _ready():
	# Connect button signals
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	
	# Show the final score
	final_score_label.text = "Final Score: " + str(GameManager.get_current_score())
	
	print("GameOverScreen: Pantalla de Game Over cargada.")

func _on_restart_pressed():
	print("GameOverScreen: Reiniciando juego...")
	# Reset the game and start again
	GameManager.start_game()

func _on_menu_pressed():
	print("GameOverScreen: Volviendo al menú principal...")
	# Go back to main menu
	get_tree().change_scene_to_file("res://Scenes/level/mainmenu.tscn")
