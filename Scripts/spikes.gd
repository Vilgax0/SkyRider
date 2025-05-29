# scripts/game/Spikes.gd
extends Area2D

@export var damage_amount: int = 1 # Cuánto daño hacen los pinchos

func _ready():
	body_entered.connect(_on_body_entered)
	print("Spikes: Listo para detectar colisiones.") # Debug

func _on_body_entered(body: Node2D):
	if body.is_in_group("players"):
		print("Spikes: Jugador colisionó con pinchos. Dando ", damage_amount, " de daño.") # Debug
		
		# 1. Quitar vida al jugador
		GameManager.take_damage(damage_amount)
		
		# 2. Calcular la dirección del empuje
		var knockback_direction: Vector2
		# Si el pincho está a la derecha del jugador, empujar al jugador a la izquierda (-X)
		if global_position.x > body.global_position.x:
			knockback_direction = Vector2.LEFT
		# Si el pincho está a la izquierda del jugador, empujar al jugador a la derecha (+X)
		else:
			knockback_direction = Vector2.RIGHT
		
		# 3. Llamar a la función de empuje del jugador
		# Asegúrate de que 'body' realmente sea el jugador (ya lo verificamos con is_in_group)
		if body is CharacterBody2D: # Una comprobación adicional de tipo
			body.apply_knockback(knockback_direction)
		
		# Opcional: Desactivar la colisión de los pinchos temporalmente
		# para evitar que el jugador pierda varias vidas en un instante
		# si se queda encima de ellos. Esto requiere un CollisionShape2D hijo.
		# Asumiendo que tienes un CollisionShape2D llamado "CollisionShape2D" como hijo:
		# $CollisionShape2D.call_deferred("set", "disabled", true)
		# await get_tree().create_timer(1.0).timeout # Esperar 1 segundo antes de re-habilitar
		# $CollisionShape2D.call_deferred("set", "disabled", false)
