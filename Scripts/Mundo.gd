extends Node2D

var player = null

@onready var spawn_point = $spawn # Asegúrate de que tienes un nodo Node2D llamado 'spawn' en tu escena Mundo.tscn.

func _ready() -> void:
	# Connect to GameManager signals
	GameManager.player_died.connect(_on_player_died)
	
	# Comprueba si GameManager tiene una escena de jugador seleccionada y si no es nula.
	# Usamos GameManager.currentPlayer directamente como lo tienes, pero recuerda que te había sugerido
	# usar GameManager.get_selected_player_scene() para una mejor práctica y encapsulación.
	if GameManager.currentPlayer != null:
		spawn_player()
	else:
		print("Mundo.gd: ADVERTENCIA: GameManager.currentPlayer es nulo. No se pudo instanciar un jugador.")
	
	# Notify GameManager that level is ready
	GameManager.level_ready()

func spawn_player():
	# Remove existing player if any
	if player != null:
		player.queue_free()
		player = null
	
	# Instantiate new player
	player = GameManager.currentPlayer.instantiate()
	add_child(player)
	
	# Position player at spawn point or last checkpoint
	var spawn_position = spawn_point.global_position
	if GameManager.has_checkpoint:
		spawn_position = GameManager.last_checkpoint_position
		print("Mundo.gd: Spawning player at checkpoint: ", spawn_position)
	else:
		print("Mundo.gd: Spawning player at spawn point: ", spawn_position)
	
	if spawn_point != null:
		# Reset player position to ensure consistent positioning
		player.position = Vector2.ZERO
		player.global_position = spawn_position
		print("Mundo.gd: Player positioned at spawn: ", player.global_position)
	else:
		# Mensaje de advertencia si el punto de aparición no se encuentra.
		print("Mundo.gd: ¡ADVERTENCIA! Nodo 'spawn' no encontrado. El jugador no se posicionará.")

func _on_player_died():
	# Respawn player when they lose a life but still have lives remaining
	print("Mundo.gd: Player died, respawning...")
	spawn_player()
