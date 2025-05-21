# GameManager.gd
extends Node

# Señales para notificar a otras partes del juego sobre eventos importantes
signal game_started
signal game_over(final_score: int)
signal score_updated(new_score: int)

var current_score: int = 0
var game_running: bool = false

func _ready():
	print("GameManager loaded.")
	# Conecta la señal de game_over para guardar el high score
	game_over.connect(SaveLoadManager.save_new_high_score)

func start_game():
	print("Game started.")
	current_score = 0
	game_running = true
	# Cambia a la escena del juego principal
	get_tree().change_scene_to_file("res://scenes/game/main_game.tscn")
	emit_signal("game_started")
	AudioManager.play_music("game_music") # Asume que tienes una música de juego

func end_game():
	print("Game over. Score:", current_score)
	game_running = false
	emit_signal("game_over", current_score)
	AudioManager.stop_music()
	# Cambia a la escena de Game Over
	get_tree().change_scene_to_file("res://scenes/ui/game_over_screen.tscn")

func add_score(amount: int):
	if game_running:
		current_score += amount
		emit_signal("score_updated", current_score)
		# print("Score:", current_score)

func reset_game_state():
	current_score = 0
	game_running = false
	# Lógica adicional para resetear el estado si es necesario
