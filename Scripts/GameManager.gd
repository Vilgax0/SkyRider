# scripts/singletons/GameManager.gd
extends Node

signal game_started
signal game_over(final_score: int, completed_level: bool)
signal score_updated(new_score: int) # Esta señal se emitirá cuando el puntaje cambie


var current_score: int = 0 # El puntaje actual del jugador
var game_running: bool = false 
# Eliminamos las variables relacionadas con el modo de juego y nivel seleccionado
# var current_game_mode: GameMode = GameMode.INFINITE
# var selected_level: int = 1

func _ready():
	print("GameManager loaded.")
	# Si quieres ver si el GameManager está cargado antes de que el juego empiece,
	# puedes añadir un print para 'game_running' aquí, pero será false al inicio.
	# print("GameManager _ready: game_running es ", game_running)

# Renombramos y simplificamos start_level_game a solo start_game
func start_game(): # Ya no recibe 'level_number'
	print("Starting Game (Fixed Level).")
	current_score = 0 # Reinicia el puntaje al inicio de cada juego
	game_running = true # ¡Esta línea es CRÍTICA para que el puntaje sume!
	emit_signal("game_started")
	print("GameManager: game_running ahora es ", game_running) # Debug
	#AudioManager.play_music("game_music") # Si tienes AudioManager
	# ¡ELIMINA LA SIGUIENTE LÍNEA!
	#get_tree().change_scene_to_file("res://scenes/game/main_game.tscn")

func end_game(completed: bool = false): # 'completed' aún puede ser útil para la pantalla de game over
	print("Game over. Score:", current_score, " Completed:", completed)
	game_running = false
	emit_signal("game_over", current_score, completed)
	#AudioManager.stop_music()
	get_tree().change_scene_to_file("res://scenes/ui/game_over_screen.tscn") # Ajusta la ruta si es diferente

func add_score(amount: int):
	print("GameManager: add_score() llamado. game_running es ", game_running) # Debug
	if game_running:
		current_score += amount
		emit_signal("score_updated", current_score)
		print("GameManager: Puntaje actualizado a ", current_score) # Debug
	else:
		print("GameManager: ¡ADVERTENCIA! Intentando sumar puntaje, pero game_running es FALSE.") # Debug

func get_current_score() -> int:
	return current_score
