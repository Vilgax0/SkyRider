# Player.gd
extends CharacterBody2D

@export var jump_force: float = 450.0
@export var horizontal_speed: float = 200.0
@export var gravity: float = 900.0 # Gravedad (ajustar para tu juego)

@onready var animated_sprite = %AnimatedSprite2D # Asume que tienes un AnimatedSprite2D

var can_jump: bool = false # Para controlar si está en una plataforma

func _ready():
	# Iniciar animaciones por defecto
	animated_sprite.play("idle")
	# GameManager.player_died.connect(_on_PlayerDied) # Si GameManager emitiera esta señal

func _physics_process(delta):
	# Aplicar gravedad
	velocity.y += gravity * delta

	# Movimiento horizontal (si la pantalla es vertical, el jugador puede moverse ligeramente a los lados)
	var direction_x = Input.get_axis("move_left", "move_right") # Define estos inputs en Project Settings -> Input Map
	velocity.x = direction_x * horizontal_speed

	# Lógica de salto automático (solo si está en el suelo/plataforma)
	if is_on_floor() and not can_jump:
		can_jump = true
		animated_sprite.play("idle") # O animación de aterrizaje

	if can_jump and !is_on_floor(): # Solo salta una vez que haya aterrizado
		if animated_sprite.animation != "jump":
			animated_sprite.play("jump")
		velocity.y = -jump_force
		can_jump = false # No puede volver a saltar hasta que aterrice
		AudioManager.play_sfx("player_jump") # Sonido de salto

	# Asegurarse de que el jugador no salga de los límites horizontales
	global_position.x = clampf(global_position.x, 0, get_viewport_rect().size.x)

	move_and_slide()

	# Lógica de "muerte" si el jugador cae demasiado bajo
	if global_position.y > get_viewport_rect().size.y + 100: # 100 píxeles por debajo de la vista
		GameManager.end_game() # Llama al GameManager para manejar el fin del juego
		queue_free() # Elimina el jugador de la escena
