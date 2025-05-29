# scripts/ui/HUD.gd
extends CanvasLayer

@onready var score_label = $Contador

func _ready():
	if score_label:
		GameManager.score_updated.connect(_on_score_updated)	
		_on_score_updated(GameManager.get_current_score())



func _on_score_updated(new_score: int):
	score_label.text = "%d" % new_score
