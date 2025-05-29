# scripts/ui/HUD.gd
extends CanvasLayer

@onready var score_label = $Contador

func _ready():
	if score_label:
		print("HUD _ready: Nodo 'Contador' encontrado.") # Debug
		GameManager.score_updated.connect(_on_score_updated)
		print("HUD _ready: Señal 'score_updated' conectada.") # Debug
		
		_on_score_updated(GameManager.get_current_score())
		print("HUD _ready: Puntaje inicializado a ", GameManager.get_current_score()) # Debug
	else:
		print("HUD _ready: ¡ERROR! Nodo 'Contador' NO ENCONTRADO. Revisa la ruta y el nombre.") # Debug


func _on_score_updated(new_score: int):
	score_label.text = "%d" % new_score
	print("HUD: Contador actualizado a: ", new_score) # Debug
