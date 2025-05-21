# AudioManager.gd
extends Node

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

var music_volume: float = 0.8
var sfx_volume: float = 0.8

func _ready():
	print("AudioManager loaded.")
	# Crea y añade los nodos AudioStreamPlayer
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Music" # Asegúrate de tener un bus "Music" en Project Settings -> Audio Bus
	music_player.volume_db = linear_to_db(music_volume)

	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	sfx_player.bus = "SFX" # Asegúrate de tener un bus "SFX" en Project Settings -> Audio Bus
	sfx_player.volume_db = linear_to_db(sfx_volume)

	# Carga la configuración de volumen si la guardaste
	load_audio_settings()


func play_music(music_name: String):
	var music_path = "res://assets/audio/music/" + music_name + ".mp3" # O .ogg, .wav
	if ResourceLoader.exists(music_path):
		music_player.stream = load(music_path)
		music_player.play()
	else:
		printerr("Music file not found: ", music_path)

func stop_music():
	music_player.stop()

func play_sfx(sfx_name: String):
	var sfx_path = "res://assets/audio/sfx/" + sfx_name + ".mp3" # O .ogg, .wav
	if ResourceLoader.exists(sfx_path):
		sfx_player.stream = load(sfx_path)
		sfx_player.play()
	else:
		printerr("SFX file not found: ", sfx_path)

func set_music_volume(volume: float): # volume should be 0.0 to 1.0
	music_volume = clampf(volume, 0.0, 1.0)
	music_player.volume_db = linear_to_db(music_volume)
	save_audio_settings()

func set_sfx_volume(volume: float): # volume should be 0.0 to 1.0
	sfx_volume = clampf(volume, 0.0, 1.0)
	sfx_player.volume_db = linear_to_db(sfx_volume)
	save_audio_settings()

func load_audio_settings():
	# Implementar carga de volumen desde SaveLoadManager o directamente de PlayerPrefs
	music_volume = SaveLoadManager.load_setting("music_volume", 0.8)
	sfx_volume = SaveLoadManager.load_setting("sfx_volume", 0.8)
	set_music_volume(music_volume) # Aplica el volumen cargado
	set_sfx_volume(sfx_volume)

func save_audio_settings():
	# Implementar guardado de volumen a través de SaveLoadManager
	SaveLoadManager.save_setting("music_volume", music_volume)
	SaveLoadManager.save_setting("sfx_volume", sfx_volume)
