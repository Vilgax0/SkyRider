# scripts/game/Torch.gd
extends Node2D 

@onready var animated_sprite = $AnimatedSprite2D 

func _ready():
	
	if animated_sprite:
		
		animated_sprite.play("fireblockoff") 
		print("Antorcha: Inicializada (apagada).") 
	else:
		print("Antorcha: ERROR - AnimatedSprite2D no encontrado.") # Debug

func turn_on():
	if animated_sprite:
		animated_sprite.play("fireblockon") 
		animated_sprite.set_frame(0) 
		print("Antorcha: ¡Encendida!") # Debug
	else:
		print("Antorcha: ERROR - No se puede encender, AnimatedSprite2D no encontrado.") # Debug

func turn_off():
	if animated_sprite:
		animated_sprite.play("fireblockoff") 
		animated_sprite.set_frame(0)
		print("Antorcha: Apagada.") # Debug
