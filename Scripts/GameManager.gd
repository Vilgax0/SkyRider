# scripts/singletons/GameManager.gd
extends Node

signal game_started
signal game_over(final_score: int, completed_level: bool)
signal score_updated(new_score: int)
signal lives_updated(new_lives_count: int)
signal player_died # Señal para cuando las vidas llegan a 0

var current_score: int = 0
var game_running: bool = false
var player_lives: int = 3 # Valor inicial de vidas (3)

var last_checkpoint_position: Vector2 = Vector2.ZERO
var has_checkpoint: bool = false

func _ready():
	print("GameManager loaded.")
	emit_signal("lives_updated", player_lives)

func start_game():
	print("Starting Game (Fixed Level).")
	current_score = 0
	player_lives = 3 # Reinicia las vidas al inicio de CADA JUEGO NUEVO
	game_running = true
	
	last_checkpoint_position = Vector2.ZERO 
	has_checkpoint = false
	
	get_tree().change_scene_to_file("res://scenes/game/main_game.tscn")
	emit_signal("game_started")
	emit_signal("lives_updated", player_lives) # Asegura que el HUD muestre las vidas reiniciadas
	print("GameManager: game_running ahora es ", game_running)

func end_game(completed: bool = false):
	print("Game over. Score:", current_score, " Completed:", completed)
	game_running = false
	emit_signal("game_over", current_score, completed)
	get_tree().change_scene_to_file("res://scenes/ui/game_over_screen.tscn")

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
		# NO emitimos lives_updated aquí si vamos a resetearlas de inmediato por muerte,
		# la emitiremos después del reset.
		# emit_signal("lives_updated", player_lives) # <-- Esto se mueve

		print("GameManager: Vidas restantes: ", player_lives)
		
		if player_lives <= 0:
			player_lives = 0 # Asegura que no baje de 0
			emit_signal("player_died") # Notifica que el jugador ha muerto (para que el Player se mueva)
			
			# === CÓDIGO NUEVO/MODIFICADO AQUÍ ===
			# Resetear vidas después de la muerte y antes de que el jugador reaparezca
			player_lives = 3 # <-- ¡Aquí se reinician las vidas!
			emit_signal("lives_updated", player_lives) # <-- Emitir la señal con el nuevo valor
			# ====================================
			
			# end_game(false) # Solo llama a end_game si quieres la pantalla de "Game Over" final.
			# Si es solo reaparición, no llames end_game aquí.
		else:
			emit_signal("lives_updated", player_lives) # Emitir lives_updated SOLO si el jugador NO ha muerto
			print("GameManager: El jugador recibió daño. Vidas: ", player_lives)
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
