# CameraFollow.gd
extends Camera2D

@export var target_node_path: NodePath
@export var smooth_speed: float = 0.1 # Velocidad de seguimiento
@export var offset_y: float = -100.0 # Offset vertical para que el jugador no esté en el centro exacto

var target: Node2D

func _ready():
	if target_node_path:
		target = get_node(target_node_path)
		if target:
			print("Camera will follow:", target.name)
		else:
			printerr("Camera target node not found at path: ", target_node_path)
	else:
		printerr("Camera target_node_path not set!")

func _process(delta):
	if target:
		var target_y = target.global_position.y + offset_y
		# Sólo sigue el eje Y si el jugador sube
		# Para que la cámara no baje si el jugador cae y permitirle morir
		if target_y < global_position.y:
			global_position.y = lerp(global_position.y, target_y, smooth_speed)
			# Puedes ajustar la velocidad horizontal si el jugador se mueve mucho
			# global_position.x = lerp(global_position.x, target.global_position.x, smooth_speed)
