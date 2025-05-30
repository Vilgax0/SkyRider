extends Node2D

var player = null

@onready var spawn_point = $spawn # Asegúrate de que tienes un nodo Node2D llamado 'spawn' en tu escena Mundo.tscn.

func _ready() -> void:
	# Comprueba si GameManager tiene una escena de jugador seleccionada y si no es nula.
	# Usamos GameManager.currentPlayer directamente como lo tienes, pero recuerda que te había sugerido
	# usar GameManager.get_selected_player_scene() para una mejor práctica y encapsulación.
	if GameManager.currentPlayer != null:
		# Corrige 'instatiate()' a 'instantiate()'
		player = GameManager.currentPlayer.instantiate()
		add_child(player)
		
		# Asegúrate de que el nodo 'spawn' exista en tu escena.
		if spawn_point != null:
			player.global_position = spawn_point.global_position
		else:
			# Mensaje de advertencia si el punto de aparición no se encuentra.
			print("Mundo.gd: ¡ADVERTENCIA! Nodo 'spawn' no encontrado. El jugador no se posicionará.")
	else:
		print("Mundo.gd: ADVERTENCIA: GameManager.currentPlayer es nulo. No se pudo instanciar un jugador.")
		# Opcional: Podrías instanciar un jugador predeterminado aquí si es necesario.
