# scripts/game/Player.gd
extends CharacterBody2D

@export var move_speed: int = 200
@export var jump_speed: float = 450.0
@onready var animated_sprite = $animated_sprite
var is_facing_right: bool = true
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var knockback_horizontal_force: float = 75.0
@export var knockback_vertical_force: float = 200.0
@export var knockback_duration: float = 0.2
var is_in_knockback: bool = false

var initial_position: Vector2 # Para guardar la posición inicial del jugador en el nivel

func _ready():
	add_to_group("players")
	print("Player _ready: Jugador añadido al grupo 'players'.") # Debug
	
	# Guardar la posición inicial del jugador en el nivel
	initial_position = global_position
	
	# Conectar la señal player_died del GameManager a una función de respawn
	GameManager.player_died.connect(_on_player_died)
	print("Player _ready: Señal 'player_died' conectada.") # Debug

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if not is_in_knockback:
		move_x()
	
	jump()
	
	move_and_slide()
	
	flip()
	update_animation()

func apply_knockback(knockback_direction: Vector2):
	if is_in_knockback:
		print("Player: Ya en knockback, ignorando nuevo empuje.") # Debug
		return

	print("Player: Aplicando knockback en dirección: ", knockback_direction) # Debug
	is_in_knockback = true
	velocity = Vector2.ZERO 
	
	velocity.x = knockback_direction.x * knockback_horizontal_force
	velocity.y = knockback_direction.y * knockback_vertical_force
	
	await get_tree().create_timer(knockback_duration).timeout
	
	is_in_knockback = false
	velocity.x = 0
	print("Player: Knockback terminado, velocidad horizontal reseteada.") # Debug

func update_animation():
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
		return

	if abs(velocity.x) > 0.1:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
func move_x():
	var input_axis = Input.get_axis("move_left", "move_right")
	velocity.x = input_axis * move_speed
	
func flip():
	if (velocity.x < 0 and not is_facing_right) or (velocity.x > 0 and is_facing_right):
		animated_sprite.flip_h = not animated_sprite.flip_h
		is_facing_right = not is_facing_right
		print("Player: Sprite volteado. is_facing_right: ", is_facing_right) # Debug
		
func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed
		AudioManager.play_jump_sound()
		print("Player: Salto iniciado.") # Debug

# --- NUEVA FUNCIÓN: Para manejar la reaparición ---
func _on_player_died():
	print("Player: El jugador ha muerto. Intentando reaparecer.") # Debug
	# Reiniciar algunas propiedades del jugador al morir (opcional, según tu juego)
	velocity = Vector2.ZERO
	is_in_knockback = false
	
	if GameManager.has_checkpoint:
		global_position = GameManager.last_checkpoint_position
		print("Player: Reaparecido en checkpoint: ", GameManager.last_checkpoint_position) # Debug
	else:
		# Si no hay checkpoint (primera muerte o no ha tocado ninguno), reaparece en la posición inicial del nivel.
		global_position = initial_position
		print("Player: No hay checkpoint activo. Reaparecido en posición inicial: ", initial_position) # Debug
	
	# Asegúrate de que el jugador se vuelva visible si lo ocultaste al morir
	# show() # Si usas hide() al morir
	
	# Opcional: Reproducir sonido de respawn, animación de aparición, etc.
	# GameManager.start_game() # No llamar start_game() aquí a menos que quieras reiniciar todo el juego.
	# Solo queremos reposicionar al jugador y restaurar vidas si el GameManager ya lo hizo.
