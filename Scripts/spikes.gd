# scripts/game/Spikes.gd
extends Area2D

@export var damage_amount: int = 1 

func _ready():
	body_entered.connect(_on_body_entered)
	print("Spikes: Listo para detectar colisiones.") # Debug

func _on_body_entered(body: Node2D):
	if not GameManager or not GameManager.game_running:
		print("Spikes: Collision detected but game not running yet, ignoring...")
		return
		
	if body.is_in_group("players"):
		print("Spikes: Jugador colisionó con pinchos. Dando ", damage_amount, " de daño.") # Debug
		
		# 1. Play damage sound
		if AudioManager:
			AudioManager.play_damage_sound()
		
		# 2. Quitar vida al jugador (GameManager se encarga de todo lo demás)
		GameManager.take_damage(damage_amount)
