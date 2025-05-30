# scripts/game/end.gd
extends Area2D

@onready var animated_sprite = $AnimatedSprite2D # Referencia al nodo AnimatedSprite2D hijo

var is_activated: bool = false 

func _ready():
	body_entered.connect(_on_body_entered)
	animated_sprite.play("endidle") 
	print("Trofeo 'end': Listo para ser activado.") # Debug

func _on_body_entered(body: Node2D):
	if body.is_in_group("players") and not is_activated:
		is_activated = true

		animated_sprite.play("endPressed") # Reproducir la animación "endPressed"
		print("Trofeo 'end': ¡Activado por el jugador! Reproduciendo 'endPressed'.") # Debug

		
		var torches = get_tree().get_nodes_in_group("torches")
		if torches.is_empty():
			print("Trofeo 'end': No se encontraron antorchas en el grupo 'torches'.") # Debug
		else:
			for torch in torches:
				
				if torch is Node and "turn_on" in torch: 
					torch.turn_on()
				else:
					print("Trofeo 'end': Un nodo en el grupo 'torches' no es una antorcha válida o no tiene 'turn_on'.") # Debug
		
	
