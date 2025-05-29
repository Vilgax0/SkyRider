# scripts/singletons/GameManager.gd
extends Node

# Señales para notificar a otras partes del juego
signal score_updated(new_score: int)
signal game_over(final_score: int) # Simplificado, si no tienes niveles aún
signal game_started

var current_score: int = 0
var game_running: bool = false
# Si de momento solo tienes juego infinito, puedes omitir GameMode y selected_level
# var current_game_mode = GameMode.INFINITE # Podrías definir esto si quieres

func _ready():
	print("GameManager loaded.")
	# Aquí puedes conectar game_over para guardar el high score si lo implementas después
	# Por ejemplo: game_over.connect(SaveLoadManager.save_high_score)

func start_game(): # Función para iniciar el juego (modo infinito por ahora)
	current_score = 0
	game_running = true
	emit_signal("game_started")
	print("Game Started.")
	# Cargar la escena del juego. Asegúrate de que esta ruta sea correcta.
	# Según tu estructura, debería ser main_game.tscn dentro de scenes/game
	get_tree().change_scene_to_file("res://scenes/game/main_game.tscn")

func end_game():
	game_running = false
	emit_signal("game_over", current_score)
	print("Game Over. Final Score:", current_score)
	# Aquí podrías cargar la escena de Game Over
	# get_tree().change_scene_to_file("res://scenes/ui/game_over_screen.tscn")
	# Por ahora, simplemente regresa al menú principal
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func add_score(amount: int):
	if game_running:
		current_score += amount
		emit_signal("score_updated", current_score)
		print("Score: ", current_score)

func get_current_score() -> int:
	return current_score

# Funciones para el high score (opcional, si no tienes SaveLoadManager aún)
var _high_score: int = 0
func get_high_score() -> int:
	return _high_score # Simplemente una variable en memoria por ahora

func save_new_high_score(final_score: int):
	if final_score > _high_score:
		_high_score = final_score
		print("New High Score:", _high_score)
