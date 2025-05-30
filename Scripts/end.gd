# scripts/game/end.gd
extends Area2D

@onready var animated_sprite = $AnimatedSprite2D # Referencia al nodo AnimatedSprite2D hijo

var is_activated: bool = false # Para asegurarnos de que el trofeo solo se active una vez

func _ready():
	body_entered.connect(_on_body_entered)
	animated_sprite.play("endidle") # Asegúrate de que tengas una animación llamada "endidle"
	print("Trofeo 'end': Listo para ser activado.") # Debug

func _on_body_entered(body: Node2D):
	if body.is_in_group("players") and not is_activated:
		is_activated = true

		animated_sprite.play("endPressed") # Reproducir la animación "endPressed"
		print("Trofeo 'end': ¡Activado por el jugador! Reproduciendo 'endPressed'.") # Debug

		# --- NUEVO: Encender todas las antorchas en el grupo "torches" ---
		var torches = get_tree().get_nodes_in_group("torches")
		if torches.is_empty():
			print("Trofeo 'end': No se encontraron antorchas en el grupo 'torches'.") # Debug
		else:
			for torch in torches:
				# Asegúrate de que el nodo sea realmente una antorcha y que tenga la función 'turn_on'
				if torch is Node and "turn_on" in torch: # 'is Node' para seguridad, 'in torch' para verificar método
					torch.turn_on()
				else:
					print("Trofeo 'end': Un nodo en el grupo 'torches' no es una antorcha válida o no tiene 'turn_on'.") # Debug
		
		# Opcional: Después de la animación "endPressed", podrías querer que el trofeo se quede en el último frame
		# o que regrese a un estado especial de "activado".
		# Si 'endPressed' es una animación que se reproduce una vez y se detiene en el último frame,
		# no necesitas hacer nada más aquí.
		# Si 'endPressed' es una animación que hace loop y quieres que se detenga:
		# animated_sprite.animation_finished.connect(_on_animation_finished)
		
		# Opcional: Notificar al GameManager que el jugador ha terminado el nivel o ha ganado.
		# GameManager.level_completed() # Si tienes una función así en tu GameManager
		
		# Opcional: Deshabilitar la colisión para que no se active de nuevo
		# $CollisionShape2D.set_deferred("disabled", true)
