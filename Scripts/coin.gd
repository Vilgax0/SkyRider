# scripts/game/Coin.gd
extends Area2D

@export var value: int = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	body_entered.connect(_on_body_entered)
	animated_sprite.play("idle")
	print("Coin _ready: Conectando señal de colisión.") # Debug

func _on_body_entered(body: Node2D):
	print("Coin: body_entered detectado por ", body.name) # Debug
	if body.is_in_group("players"):
		print("Coin: Colisión con el jugador detectada. Valor de banana: ", value) # Debug
		collision_shape.call_deferred("set", "disabled", true)
		
		GameManager.add_score(value) # ¡Aquí es donde se suma el puntaje!
		
		animated_sprite.play("pickup")
		await animated_sprite.animation_finished
		queue_free()
		print("Coin: Banana eliminada.") # Debug
	else:
		print("Coin: Colisión con un cuerpo que NO es el jugador: ", body.name) # Debug
