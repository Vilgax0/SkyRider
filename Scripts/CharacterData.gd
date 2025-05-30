# scripts/resources/CharacterData.gd
class_name CharacterData # Permite crear este recurso desde el Inspector
extends Resource

@export var key: String
@export var Imagen: Texture2D # Esta será la miniatura/imagen estática para la pantalla de Diseño
@export var Scene: PackedScene # <--- ¡IMPORTANTE! Aquí se referencia el archivo .tscn del personaje
