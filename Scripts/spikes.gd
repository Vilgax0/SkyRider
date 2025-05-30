# scripts/game/Spikes.gd
extends Area2D

@export var damage_amount: int = 1 # Cuánto daño hacen los pinchos

func _ready():
	body_entered.connect(_on_body_entered)
	print("Spikes: Listo para detectar colisiones.") # Debug

func _on_body_entered(body: Node2D):
	if body.is_in_group("players"):
		print("Spikes: Jugador colisionó con pinchos. Dando ", damage_amount, " de daño.") # Debug
		
		# 1. Play damage sound
		AudioManager.play_damage_sound()
		
		# 2. Quitar vida al jugador (GameManager se encarga de todo lo demás)
		GameManager.take_damage(damage_amount)
		
		# 3. Disable collision temporarily to avoid multiple hits
		#monitoring = false
		#await get_tree().create_timer(1.0).timeout
		#monitoring = true
