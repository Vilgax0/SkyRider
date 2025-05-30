# scripts/game/Checkpoint.gd
extends Area2D

var is_active: bool = false # Para saber si ya ha sido activado por el jugador

@onready var animated_sprite = $AnimatedSprite2D # Asume que tienes este nodo en tu escena

func _ready():
	# Conectar la señal body_entered del Area2D
	body_entered.connect(_on_body_entered)
	
	# Inicializa el checkpoint con la animación 'noidle' (no activado)
	animated_sprite.play("noidle") # Asegúrate de que esta animación sea un solo frame y no haga loop
	animated_sprite.set_frame(0) # Asegura que esté en el primer (y único) frame si es noidle
	
	# Conecta la señal animation_finished para la animación 'preidle'
	animated_sprite.animation_finished.connect(_on_animation_finished)
	
	print("Checkpoint: Listo para activar.") # Debug

func _on_body_entered(body: Node2D):
	
	if body.is_in_group("players") and not is_active:
		is_active = true
		
		
		GameManager.set_current_checkpoint(global_position)
		
		
		AudioManager.play_checkpoint_sound()
		
		# 3. Reproducir la animación 'preidle' (salir la bandera)
		if animated_sprite:
			animated_sprite.play("preidle") 
			print("Checkpoint: Reproduciendo 'preidle'.")
		
		print("Checkpoint: Activado por el jugador en ", global_position) 

func _on_animation_finished():
	
	if animated_sprite.animation == "preidle":
		animated_sprite.play("idle") 
		print("Checkpoint: Transición a 'idle' completada.")
