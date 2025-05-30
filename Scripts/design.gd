extends Control

@export var Personajes: Array[CharacterData]
@onready var sprite = $Sprite2D

var cont: int = 0

func _ready():
	sprite.texture = Personajes[0].Imagen

func sig() -> void:
	if cont < Personajes.size() -1: 
		cont += 1
		sprite.texture = Personajes[cont].Imagen
	
func ant() -> void:
	if cont >= 0:
		cont -= 1
		sprite.texture = Personajes[cont].Imagen

func select() -> void:
	GameManager.currentPlayer = Personajes[cont].Scene

func _on_siguiente_pressed() -> void:
	sig()


func _on_anterior_pressed() -> void:
	ant()


func _on_seleccionar_pressed() -> void:
	select()
	get_tree().change_scene_to_file("res://Scenes/level/level1.tscn")
