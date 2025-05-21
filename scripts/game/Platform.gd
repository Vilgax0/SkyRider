# Platform.gd
extends StaticBody2D

# Puedes añadir propiedades para diferentes tipos de plataformas aquí
# @export var is_breakable: bool = false
# @export var disappears_after_touch: bool = false

func _ready():
	# Configura la colisión si es necesario
	pass

func _on_Player_landed_on_me():
	# Puedes añadir lógica aquí si quieres que la plataforma haga algo
	# cuando el jugador aterriza en ella (ej. cambiar color, desaparecer)
	pass
