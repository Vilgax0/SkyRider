# scripts/ui/HUD.gd
extends CanvasLayer

@onready var score_label = $label_contador # Asegúrate que este Label se llame 'label_contador' en tu escena HUD
@onready var lives_label = $label_vidas    # Asegúrate que este Label se llame 'label_vidas' en tu escena HUD

func _ready():
	# Verifica que ambos Labels se hayan encontrado.
	# Es una buena práctica para evitar errores si no están correctamente enlazados.
	if score_label and lives_label:
		print("HUD _ready: Nodos 'label_contador' y 'label_vidas' encontrados.") # Debug
		
		# Conecta la señal 'score_updated' del GameManager a la función _on_score_updated
		GameManager.score_updated.connect(_on_score_updated)
		print("HUD _ready: Señal 'score_updated' conectada.") # Debug
		
		# Conecta la ¡nueva! señal 'lives_updated' del GameManager a la función _on_lives_updated
		GameManager.lives_updated.connect(_on_lives_updated)
		print("HUD _ready: Señal 'lives_updated' conectada.") # Debug
		
		# Inicializa ambos Labels con los valores actuales al inicio del juego
		_on_score_updated(GameManager.get_current_score())
		print("HUD _ready: Puntaje inicializado a ", GameManager.get_current_score()) # Debug
		
		_on_lives_updated(GameManager.get_player_lives()) # Inicializa las vidas
		print("HUD _ready: Vidas inicializadas a ", GameManager.get_player_lives()) # Debug
	else:
		print("HUD _ready: ¡ERROR! Uno o ambos nodos de Label (label_contador, label_vidas) NO ENCONTRADOS. Revisa rutas y nombres.") # Debug


# Función que se llama cada vez que el puntaje se actualiza en el GameManager
func _on_score_updated(new_score: int):
	# Actualiza el texto del Label con el nuevo puntaje
	score_label.text = "%d" % new_score # Puedes cambiar "Bananas: " por "Score: " o nada
	print("HUD: Contador actualizado a: ", new_score) # Debug

# ¡Nueva función para actualizar el Label de vidas!
func _on_lives_updated(new_lives_count: int):
	# Actualiza el texto del Label con el nuevo conteo de vidas
	lives_label.text = "%d" % new_lives_count
	print("HUD: Vidas actualizadas a: ", new_lives_count) # Debug
