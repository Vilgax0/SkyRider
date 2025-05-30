# scripts/autoload/AudioManager.gd
extends Node

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()

var music_v1: AudioStream
var music_v2: AudioStream
var current_track: int = 1 # 1 for v1, 2 for v2
var is_muted: bool = false

func _ready():
	# Add the AudioStreamPlayer to the scene tree
	add_child(music_player)
	
	# Load the music files
	music_v1 = load("res://Sprites/music/Digital Dreamscape ext v1.mp3")
	music_v2 = load("res://Sprites/music/Digital Dreamscape ext v2.mp3")
	
	# Connect the finished signal to handle track switching
	music_player.finished.connect(_on_music_finished)
	
	# Set the music player to the Master bus
	music_player.bus = "Master"
	
	# Load saved mute state if SaveManager exists
	if has_node("/root/SaveManager"):
		is_muted = SaveManager.get_mute_state()
	
	# Start playing the first track (if not muted)
	play_music()
	
	print("AudioManager: Music system initialized")

func play_music():
	if is_muted:
		return
		
	if current_track == 1:
		music_player.stream = music_v1
		print("AudioManager: Playing Digital Dreamscape v1")
	else:
		music_player.stream = music_v2
		print("AudioManager: Playing Digital Dreamscape v2")
	
	music_player.play()

func _on_music_finished():
	# Switch to the other track
	if current_track == 1:
		current_track = 2
	else:
		current_track = 1
	
	# Play the next track
	play_music()

func toggle_mute():
	is_muted = !is_muted
	
	if is_muted:
		music_player.stop()
		print("AudioManager: Music muted")
	else:
		play_music()
		print("AudioManager: Music unmuted")
	
	# Save mute state if SaveManager exists
	if has_node("/root/SaveManager"):
		SaveManager.set_mute_state(is_muted)
	
	return is_muted

func set_mute(mute_state: bool):
	is_muted = mute_state
	
	if is_muted:
		music_player.stop()
	else:
		play_music()
	
	# Save mute state if SaveManager exists
	if has_node("/root/SaveManager"):
		SaveManager.set_mute_state(is_muted)

func get_mute_state() -> bool:
	return is_muted

func stop_music():
	music_player.stop()

func resume_music():
	if not is_muted:
		music_player.play()
