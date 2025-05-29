# scripts/singletons/GameManager.gd
extends Node

signal game_started
signal game_over(final_score: int, completed_level: bool)
signal score_updated(new_score: int) # Esta señal se emitirá cuando el puntaje cambie

enum GameMode { INFINITE, LEVEL_BASED } 

var current_score: int = 0 # El puntaje actual del jugador
var game_running: bool = false
var current_game_mode: GameMode = GameMode.INFINITE 
var selected_level: int = 1 

func _ready():
	print("GameManager loaded.")
	# Conecta la señal game_over para guardar el high score
	#game_over.connect(SaveLoadManager.save_new_high_score) 
	# Opcional: Si quieres desbloquear niveles por puntaje total acumulado (no solo high score)
	# game_over.connect(func(score, completed): if completed: unlock_next_level(selected_level))


func start_infinite_game():
	print("Starting Infinite Game.")
	current_score = 0 # Reinicia el puntaje al inicio de cada juego
	game_running = true
	current_game_mode = GameMode.INFINITE
	selected_level = 0 
	get_tree().change_scene_to_file("res://scenes/game/main_game.tscn")
	emit_signal("game_started")
	#AudioManager.play_music("game_music")

func start_level_game(level_number: int):
	print("Starting Level Game:", level_number)
	current_score = 0 # Reinicia el puntaje
	game_running = true
	current_game_mode = GameMode.LEVEL_BASED
	selected_level = level_number
	get_tree().change_scene_to_file("res://scenes/game/main_game.tscn")
	emit_signal("game_started")
	#AudioManager.play_music("game_music")

func end_game(completed: bool = false): 
	print("Game over. Score:", current_score, " Completed:", completed)
	game_running = false
	# Emite el puntaje final y si el nivel fue completado
	emit_signal("game_over", current_score, completed) 
	#AudioManager.stop_music()
	get_tree().change_scene_to_file("res://scenes/ui/game_over_screen.tscn")

func add_score(amount: int):
	if game_running: # Solo añade puntaje si el juego está en curso
		current_score += amount
		emit_signal("score_updated", current_score) # Emite la señal para actualizar el HUD

#func get_high_score() -> int:
	#return SaveLoadManager.get_high_score()

func get_current_game_mode() -> GameMode:
	return current_game_mode

func get_selected_level() -> int:
	return selected_level

# ... (otras funciones como unlock_next_level) ...
