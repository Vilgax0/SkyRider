extends Node2D

var player = null

@onready var spawn_point = $spawn 

func _ready() -> void:
	GameManager.player_died.connect(_on_player_died)
	
	if GameManager.currentPlayer != null:
		spawn_player()
	else:
		print("Mundo.gd: ADVERTENCIA: GameManager.currentPlayer es nulo. No se pudo instanciar un jugador.")
	
	
	GameManager.level_ready()

func spawn_player():
	
	if player != null:
		player.queue_free()
		player = null
	
	
	player = GameManager.currentPlayer.instantiate()
	add_child(player)
	
	
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
		
		print("Mundo.gd: ¡ADVERTENCIA! Nodo 'spawn' no encontrado. El jugador no se posicionará.")

func _on_player_died():
	print("Mundo.gd: Player died, respawning...")
	spawn_player()
