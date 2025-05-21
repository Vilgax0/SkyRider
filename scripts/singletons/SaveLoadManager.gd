# SaveLoadManager.gd
extends Node

const SAVE_FILE_PATH = "user://game_data.dat" # Ruta del archivo de guardado
const HIGH_SCORE_KEY = "high_score"

var high_score: int = 0
var game_settings: Dictionary = {}

func _ready():
	print("SaveLoadManager loaded.")
	load_data()

func load_data():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		print("Save file not found. Initializing default data.")
		high_score = 0
		game_settings = {
			"music_volume": 0.8,
			"sfx_volume": 0.8
		}
		save_data() # Guarda los valores por defecto
		return

	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file:
		var data = file.get_var(true) # true para decodificar como JSON si se guardó como texto
		file.close()

		if data is Dictionary:
			high_score = data.get(HIGH_SCORE_KEY, 0)
			game_settings = data.get("settings", {})
			print("Data loaded successfully.")
			print("High Score:", high_score)
			print("Settings:", game_settings)
		else:
			printerr("Corrupt save file or invalid data format.")
	else:
		printerr("Failed to open save file for reading.")

func save_data():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		var data_to_save = {
			HIGH_SCORE_KEY: high_score,
			"settings": game_settings
		}
		file.store_var(data_to_save, true) # true para codificar como JSON si quieres texto plano
		file.close()
		print("Data saved successfully.")
	else:
		printerr("Failed to open save file for writing.")

func save_new_high_score(new_score: int):
	if new_score > high_score:
		high_score = new_score
		print("New high score achieved:", high_score)
		save_data()

func get_high_score() -> int:
	return high_score

func save_setting(key: String, value):
	game_settings[key] = value
	save_data()

func load_setting(key: String, default_value):
	return game_settings.get(key, default_value)
