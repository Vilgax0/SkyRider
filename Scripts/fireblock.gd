# scripts/game/Torch.gd
extends Node2D # O el tipo de nodo raíz de tu antorcha, ej. Sprite2D, AnimatedSprite2D

@onready var animated_sprite = $AnimatedSprite2D # Asegúrate que tu AnimatedSprite2D se llame así

func _ready():
	# Asegúrate que el AnimatedSprite2D esté presente
	if animated_sprite:
		# Inicializa la antorcha apagada
		animated_sprite.play("fireblockoff") # Animación para cuando la antorcha está apagada
		print("Antorcha: Inicializada (apagada).") # Debug
	else:
		print("Antorcha: ERROR - AnimatedSprite2D no encontrado.") # Debug

func turn_on():
	if animated_sprite:
		animated_sprite.play("fireblockon") # Animación para cuando la antorcha está encendida
		animated_sprite.set_frame(0) # Asegura que empiece desde el primer frame de la animación
		print("Antorcha: ¡Encendida!") # Debug
	else:
		print("Antorcha: ERROR - No se puede encender, AnimatedSprite2D no encontrado.") # Debug

func turn_off():
	if animated_sprite:
		animated_sprite.play("fireblockoff") # Vuelve a la animación de apagado si es necesario
		animated_sprite.set_frame(0)
		print("Antorcha: Apagada.") # Debug
