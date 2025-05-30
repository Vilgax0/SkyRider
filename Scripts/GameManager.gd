# scripts/singletons/GameManager.gd
extends Node

signal game_started
signal game_over(final_score: int, completed_level: bool)
signal score_updated(new_score: int)
signal lives_updated(new_lives_count: int)
signal player_died # Señal para cuando las vidas llegan a 0

var current_score: int = 0
var game_running: bool = false
var player_lives: int = 5 # Valor inicial de vidas (5)

var last_checkpoint_position: Vector2 = Vector2.ZERO
var has_checkpoint: bool = false

var currentPlayer: PackedScene = null

func _ready():
	print("GameManager loaded.")
	# Set a default player character if none is selected
	if currentPlayer == null:
		currentPlayer = preload("res://Scenes/Player/maskdude.tscn")
		print("GameManager: Set default player to maskdude")
	# Don't emit lives_updated here, wait for game to actually start

func start_game():
	print("Starting Game (Fixed Level).")
	current_score = 0
	player_lives = 5 # Reinicia las vidas al inicio de CADA JUEGO NUEVO
	
	last_checkpoint_position = Vector2.ZERO
	has_checkpoint = false
	
	# Set game_running to true immediately since we're transitioning
	game_running = true
	
	get_tree().change_scene_to_file("res://Scenes/level/level1.tscn")
	
	# Emit signals after scene change
	emit_signal("game_started")
	emit_signal("lives_updated", player_lives) # Asegura que el HUD muestre las vidas reiniciadas
	print("GameManager: game_running set to true, starting level")

func end_game(completed: bool = false):
	print("Game over. Score:", current_score, " Completed:", completed)
	game_running = false
	emit_signal("game_over", current_score, completed)
	get_tree().change_scene_to_file("res://Scenes/level/gameover.tscn")

# Add a function to be called by the level when it's ready
func level_ready():
	game_running = true
	emit_signal("game_started")
	emit_signal("lives_updated", player_lives)
	print("GameManager: Level ready, game_running set to true")

func add_score(amount: int):
	if game_running:
		current_score += amount
		emit_signal("score_updated", current_score)
		print("GameManager: Puntaje actualizado a ", current_score)
	else:
		print("GameManager: ¡ADVERTENCIA! Intentando sumar puntaje, pero game_running es FALSE.")

func take_damage(amount: int = 1):
	if game_running:
		player_lives -= amount
		print("GameManager: Vidas restantes: ", player_lives)
		
		if player_lives <= 0:
			player_lives = 0 # Asegura que no baje de 0
			emit_signal("lives_updated", player_lives)
			print("GameManager: ¡GAME OVER! El jugador ha perdido todas las vidas.")
			game_running = false  # Set to false before changing scene
			get_tree().change_scene_to_file("res://Scenes/level/gameover.tscn") # Llamar a game over
		else:
			emit_signal("player_died") # Solo notifica muerte si aún tiene vidas
			emit_signal("lives_updated", player_lives)
			print("GameManager: El jugador perdió una vida. Vidas restantes: ", player_lives)
	else:
		print("GameManager: ¡ADVERTENCIA! Recibiendo daño, pero juego no está en curso.")

func get_current_score() -> int:
	return current_score

func get_player_lives() -> int:
	return player_lives

func set_current_checkpoint(position: Vector2):
	last_checkpoint_position = position
	has_checkpoint = true
	print("GameManager: Checkpoint activado en posición: ", position)
