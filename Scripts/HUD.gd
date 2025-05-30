# scripts/ui/HUD.gd
extends CanvasLayer

@onready var score_label = $label_contador # Asegúrate que este Label se llame 'label_contador' en tu escena HUD
@onready var lives_label = $label_vidas    # Asegúrate que este Label se llame 'label_vidas' en tu escena HUD

# --- NUEVAS REFERENCIAS PARA EL EASTER EGG ---
@onready var banana_image = $banana # Tu TextureRect de la banana
@onready var easter_egg_panel = $EasterEggPanel # El Panel contenedor del mensaje y la imagen
@onready var message_label = $EasterEggPanel/MessageLabel # El Label para el mensaje
@onready var dog_image = $EasterEggPanel/Image # El TextureRect para la imagen del profesor
@onready var easter_egg_display_timer = $EasterEggDisplayTimer # El Timer para controlar la duración del display

# --- NUEVAS VARIABLES PARA LA LÓGICA DEL EASTER EGG ---
var banana_click_count: int = 0
@export var clicks_required_for_egg: int = 10
@export var egg_display_duration: float = 5.0 # Segundos que duran el mensaje/imagen visibles

func _ready():
	# Verifica que ambos Labels se hayan encontrado.
	# Es una buena práctica para evitar errores si no están correctamente enlazados.
	if score_label and lives_label:
		print("HUD _ready: Nodos 'label_contador' y 'label_vidas' encontrados.") # Debug
		
		# Conecta la señal 'score_updated' del GameManager a la función _on_score_updated
		GameManager.score_updated.connect(_on_score_updated)
		print("HUD _ready: Señal 'score_updated' conectada.") # Debug
		
		# Conecta la ¡nueva! señal 'lives_updated' del GameManager a la función _on_lives_updated
		GameManager.lives_updated.connect(_on_lives_updated)
		print("HUD _ready: Señal 'lives_updated' conectada.") # Debug
		
		# Inicializa ambos Labels con los valores actuales al inicio del juego
		_on_score_updated(GameManager.get_current_score())
		print("HUD _ready: Puntaje inicializado a ", GameManager.get_current_score()) # Debug
		
		_on_lives_updated(GameManager.get_player_lives()) # Inicializa las vidas
		print("HUD _ready: Vidas inicializadas a ", GameManager.get_player_lives()) # Debug
	else:
		print("HUD _ready: ¡ERROR! Uno o ambos nodos de Label NO ENCONTRADOS. Revisa rutas y nombres.")
	# --- INICIALIZACIÓN DEL EASTER EGG (NUEVO) ---
	if banana_image:
		# Para que el TextureRect 'banana' pueda recibir eventos de clic, su 'Mouse Filter' debe ser 'STOP' en el Inspector.
		banana_image.gui_input.connect(_on_banana_gui_input)
		print("HUD: Señal 'gui_input' de banana conectada.") # Debug
	else:
		print("HUD: ¡ADVERTENCIA! Nodo 'banana' (TextureRect) no encontrado. El Easter Egg de la banana no funcionará.") # Debug

	if easter_egg_panel:
		easter_egg_panel.visible = false # Asegura que el panel del easter egg esté oculto al inicio
		print("HUD: Panel del Easter Egg inicializado como invisible.") # Debug
	else:
		print("HUD: ¡ADVERTENCIA! Nodo 'EasterEggPanel' no encontrado. El Easter Egg no se mostrará.") # Debug

	if easter_egg_display_timer:
		easter_egg_display_timer.one_shot = true
		easter_egg_display_timer.timeout.connect(_on_easter_egg_display_timer_timeout)
		print("HUD: Timer del Easter Egg configurado.") # Debug
	else:
		print("HUD: ¡ADVERTENCIA! Nodo 'EasterEggDisplayTimer' no encontrado. El Easter Egg no se ocultará automáticamente.") # Debug


# Función que se llama cada vez que el puntaje se actualiza en el GameManager
func _on_score_updated(new_score: int):
	# Actualiza el texto del Label con el nuevo puntaje
	score_label.text = "%d" % new_score # Puedes cambiar "Bananas: " por "Score: " o nada
	print("HUD: Contador actualizado a: ", new_score) # Debug

# Función para actualizar el Label de vidas
func _on_lives_updated(new_lives_count: int):
	# Actualiza el texto del Label con el nuevo conteo de vidas
	lives_label.text = "%d" % new_lives_count
	print("HUD: Vidas actualizadas a: ", new_lives_count) # Debug

# --- NUEVAS FUNCIONES PARA EL EASTER EGG --
func _on_banana_gui_input(event: InputEvent):
	# Detecta los clics del mouse en el área de la banan
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			banana_click_count += 1
			print("Banana clicada: ", banana_click_count, " veces.") # Debug
			
			if banana_click_count >= clicks_required_for_egg:
				trigger_easter_egg()
				banana_click_count = 0 # Reinicia el contador para que no se active de nuevo inmediatamente
				

func trigger_easter_egg():
	print("¡Easter Egg de la Banana activado!")
	
	if easter_egg_panel:
		easter_egg_panel.visible = true
		
		if message_label:
			message_label.text = "Eres un Goloso por las bananas"
			
		if dog_image:
			dog_image.visible = true # Asegura que la imagen sea visible
			# Asegúrate de que la textura ya esté asignada en el editor o cárgala aquí si es necesario
			# professor_image.texture = load("res://assets/images/professor_photo.png") # Ejemplo de carga si no está en el editor
			
		# Inicia el timer para ocultar el Easter Egg
		if easter_egg_display_timer:
			easter_egg_display_timer.start(egg_display_duration)
			

func _on_easter_egg_display_timer_timeout():
	# Oculta el panel y su contenido cuando el timer termina
	if easter_egg_panel:
		easter_egg_panel.visible = false
		print("Easter Egg de la Banana oculto.") # Debug
