# MainGame.gd
extends Node2D

@onready var player_spawn_position = %PlayerSpawnPosition
@onready var score_display_label = %ScoreDisplayLabel # Para mostrar el puntaje en el HUD

@export var platform_scene: PackedScene = preload("res://scenes/game/platform.tscn")
@export var player_scene: PackedScene = preload("res://scenes/game/player.tscn")

@export var initial_platforms: int = 5
@export var platform_spacing_y: float = 150.0 # Espacio vertical entre plataformas
@export var platform_width_min: float = 80.0
@export var platform_width_max: float = 200.0

var current_player: CharacterBody2D
var last_platform_y: float # Para rastrear la altura de la última plataforma generada

func _ready():
	spawn_initial_platforms()
	spawn_player()
	GameManager.score_updated.connect(_on_ScoreUpdated) # Conectar señal de GameManager

func _physics_process(delta):
	# Generación continua de plataformas a medida que el jugador sube
	if current_player and current_player.global_position.y < last_platform_y - (get_viewport_rect().size.y * 0.7):
		generate_new_platform()


func spawn_player():
	if player_scene:
		current_player = player_scene.instantiate()
		add_child(current_player)
		current_player.global_position = player_spawn_position.global_position
		# Conecta la señal de 'player_died' del jugador al GameManager
		# Esto se haría si Player.gd tuviera una señal player_died,
		# pero como Player.gd llama directamente a GameManager.player_died, no es necesario aquí.


func spawn_initial_platforms():
	# Elimina plataformas existentes si las hay (para reintentar)
	for child in get_children():
		if child.name.contains("Platform"):
			child.queue_free()

	last_platform_y = get_viewport_rect().size.y # Empieza a generar desde abajo
	for i in range(initial_platforms):
		generate_new_platform(true) # true para las plataformas iniciales

func generate_new_platform(initial_spawn: bool = false):
	if not platform_scene:
		printerr("Platform scene not set!")
		return

	var new_platform = platform_scene.instantiate()
	add_child(new_platform)

	var platform_width = randf_range(platform_width_min, platform_width_max)
	new_platform.scale.x = platform_width / new_platform.get_node("CollisionShape2D").shape.size.x # Ajusta el tamaño de la plataforma

	var x_pos = randf_range(50, get_viewport_rect().size.x - 50) # Posición X aleatoria
	var y_pos: float

	if initial_spawn:
		y_pos = last_platform_y - (i * platform_spacing_y) # Genera desde abajo hacia arriba
	else:
		y_pos = last_platform_y - platform_spacing_y # Genera encima de la última

	new_platform.position = Vector2(x_pos, y_pos)
	last_platform_y = y_pos # Actualiza la última posición Y generada

	# Eliminar plataformas viejas (opcional para optimización si se van a generar muchísimas)
	# var platforms_to_remove = []
	# for child in get_children():
	# 	if child.name.contains("Platform") and child.global_position.y > current_player.global_position.y + get_viewport_rect().size.y:
	# 		platforms_to_remove.append(child)
	# for platform in platforms_to_remove:
	# 	platform.queue_free()


func _on_ScoreUpdated(new_score: int):
	score_display_label.text = "Score: %d" % new_score

# Asegúrate de conectar esta escena como la escena principal del juego
# y añadir los nodos (PlayerSpawnPosition, ScoreDisplayLabel) en tu .tscn
