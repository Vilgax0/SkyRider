# scripts/game/Coin.gd (o scripts/game/Banana.gd)
extends Area2D # ¡IMPORTANTE! El nodo raíz de tu escena de banana debe ser un Area2D.

@export var value: int = 1 # Valor de la banana

@onready var animated_sprite = $Coin2D/AnimatedSprite2D # Asume que tu AnimatedSprite2D es hijo directo de Area2D.
												# Si es hijo de Coin2D, entonces sería $Coin2D/AnimatedSprite2D

func _ready():
	# Conecta la señal "body_entered" de Area2D.
	body_entered.connect(_on_body_entered)

	# Reproduce la animación de la banana girando
	animated_sprite.play("idle") 

func _on_body_entered(body: Node2D):
	# Verifica que el cuerpo que entró es el jugador usando el grupo "players"
	if body.is_in_group("players"): 
		GameManager.add_score(value) # Llama a la función global del GameManager
		# Puedes añadir un sonido de recolección aquí si tienes AudioManager
		# AudioManager.play_sfx("banana_pickup")

		# Inicia la animación de recolección y luego elimina la banana
		animated_sprite.play("pickup")
		await animated_sprite.animation_finished # Espera a que la animación termine
		queue_free() # Elimina la banana de la escena
