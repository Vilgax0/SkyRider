# scripts/game/Coin.gd
extends Area2D

@export var value: int = 1
@export var coin_id: String = "" 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	body_entered.connect(_on_body_entered)
	animated_sprite.play("idle")
	print("Coin _ready: Conectando señal de colisión.") 
	
	
	if coin_id != "" and SaveManager.is_coin_collected(coin_id):
		queue_free()
		return

func _on_body_entered(body: Node2D):
	print("Coin: body_entered detectado por ", body.name) # Debug
	if body.is_in_group("players"):
		print("Coin: Colisión con el jugador detectada. Valor de banana: ", value) # Debug
		collision_shape.call_deferred("set", "disabled", true)
		
		GameManager.add_score(value) 
		AudioManager.play_coin_sound()
		
		
		if coin_id != "":
			SaveManager.collect_coin(coin_id)
		
		animated_sprite.play("pickup")
		await animated_sprite.animation_finished
		queue_free()
		print("Coin: Banana eliminada.") # Debug
	else:
		print("Coin: Colisión con un cuerpo que NO es el jugador: ", body.name) # Debug
