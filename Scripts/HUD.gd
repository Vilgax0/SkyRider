# scripts/ui/HUD.gd
extends CanvasLayer

@onready var score_label = $label_contador 
@onready var lives_label = $label_vidas    

func _ready():
	
	if score_label and lives_label:
		print("HUD _ready: Nodos 'label_contador' y 'label_vidas' encontrados.") # Debug
		
		
		GameManager.score_updated.connect(_on_score_updated)
		print("HUD _ready: Señal 'score_updated' conectada.") # Debug
		
		
		GameManager.lives_updated.connect(_on_lives_updated)
		print("HUD _ready: Señal 'lives_updated' conectada.") # Debug
		
		
		_on_score_updated(GameManager.get_current_score())
		print("HUD _ready: Puntaje inicializado a ", GameManager.get_current_score()) # Debug
		
		_on_lives_updated(GameManager.get_player_lives()) # Inicializa las vidas
		print("HUD _ready: Vidas inicializadas a ", GameManager.get_player_lives()) # Debug
	else:
		print("HUD _ready: ¡ERROR! Uno o ambos nodos de Label (label_contador, label_vidas) NO ENCONTRADOS. Revisa rutas y nombres.") # Debug


# Función que se llama cada vez que el puntaje se actualiza en el GameManager
func _on_score_updated(new_score: int):
	# Actualiza el texto del Label con el nuevo puntaje
	score_label.text = "%d" % new_score 
	print("HUD: Contador actualizado a: ", new_score) # Debug


func _on_lives_updated(new_lives_count: int):

	lives_label.text = "%d" % new_lives_count
	print("HUD: Vidas actualizadas a: ", new_lives_count) # Debug
