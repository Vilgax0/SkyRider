# scripts/game/Checkpoint.gd
extends Area2D

var is_active: bool = false # Para saber si ya ha sido activado por el jugador

@onready var animated_sprite = $AnimatedSprite2D # Asume que tienes uno para animar

func _ready():
	body_entered.connect(_on_body_entered)
	# Opcional: Si tienes una animación de 'idle' para un checkpoint inactivo
	animated_sprite.play("idle")
	print("Checkpoint: Listo para activar.") # Debug

func _on_body_entered(body: Node2D):
	if body.is_in_group("players") and not is_active:
		is_active = true
		
		# 1. Notificar al GameManager de la posición de este checkpoint
		GameManager.set_current_checkpoint(global_position)
		
		# 2. Opcional: Cambiar la animación a "activo"
		# if animated_sprite:
		# 	animated_sprite.play("active")
		
		print("Checkpoint: Activado por el jugador en ", global_position) # Debug
