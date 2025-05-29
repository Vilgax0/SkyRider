extends CharacterBody2D

@export var move_speed: int = 200 # Asegúrate de que tenga un valor por defecto si no lo asignas en el Inspector
@export var jump_speed: float = 450.0 # Asegúrate de que tenga un valor por defecto
@onready var animated_sprite = $animated_sprite # Asume que tu AnimatedSprite2D se llama "animated_sprite"
var is_facing_right: bool = true # Corregido a 'right' para consistencia
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Aplicar gravedad primero para que el salto y el movimiento se integren bien
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_x() # Maneja el movimiento horizontal
	jump() # Maneja el salto (ya no necesita delta aquí porque la gravedad se aplica antes)
	
	move_and_slide() # Mueve el personaje y gestiona colisiones
	
	flip() # Voltea el sprite si cambia de dirección
	update_animation() # Actualiza la animación después de que la velocidad se ha calculado y movido


func update_animation():
	if not is_on_floor():
		if velocity.y < 0: # Subiendo
			animated_sprite.play("jump")
		else: # Cayendo
			animated_sprite.play("fall")
		return # No cheques otras animaciones si no está en el suelo

	# Si está en el suelo
	if abs(velocity.x) > 0.1: # Usar un umbral pequeño para evitar "run" por pequeños movimientos
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
func move_x():
	# ¡CORRECCIÓN CRÍTICA AQUÍ! "move_rigth" a "move_right"
	var input_axis = Input.get_axis("move_left", "move_right") 
	velocity.x = input_axis * move_speed
	
func flip():
	# Solo voltea si la dirección de movimiento horizontal es diferente a la dirección actual del sprite
	if (is_facing_right and velocity.x > 0) or (not is_facing_right and velocity.x < 0):
		# No necesitas multiplicar por -1 el `scale.x` si ya está en -1 o 1
		animated_sprite.flip_h = not animated_sprite.flip_h
		is_facing_right = not is_facing_right
		
func jump(): # Ya no necesita 'delta' como parámetro porque la gravedad ya se aplica en _physics_process
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed
		# Considera reproducir un sonido de salto aquí
		# AudioManager.play_sfx("player_jump") # Si tienes tu AudioManager configurado
