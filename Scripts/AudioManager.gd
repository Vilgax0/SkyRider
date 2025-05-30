# scripts/autoload/AudioManager.gd
extends Node

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var jump_sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var coin_sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var damage_sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var checkpoint_sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()

var music_v1: AudioStream
var music_v2: AudioStream
var jump_sound: AudioStream
var coin_sound: AudioStream
var damage_sound: AudioStream
var checkpoint_sound: AudioStream
var current_track: int = 1 
var is_muted: bool = false

func _ready(): 
	add_child(music_player)
	add_child(jump_sfx_player)
	add_child(coin_sfx_player)
	add_child(damage_sfx_player)
	add_child(checkpoint_sfx_player)
	
	# Load the music files
	music_v1 = load("res://Sprites/music/Digital Dreamscape ext v1.mp3")
	music_v2 = load("res://Sprites/music/Digital Dreamscape ext v2.mp3")
		# Load the sound effects
	jump_sound = load("res://Sprites/music/jumping.mp3")
	coin_sound = load("res://Sprites/music/coin.mp3")
	damage_sound = load("res://Sprites/music/douh.mp3")
	checkpoint_sound = load("res://Sprites/music/checkpoint.mp3")
	
	print("AudioManager: Loaded checkpoint sound: ", checkpoint_sound != null)
	
	
	music_player.finished.connect(_on_music_finished)

	music_player.bus = "Master"
		
	jump_sfx_player.bus = "Master"
	coin_sfx_player.bus = "Master"
	damage_sfx_player.bus = "Master"
	checkpoint_sfx_player.bus = "Master"
	
	# Load saved mute state if SaveManager exists
	if has_node("/root/SaveManager"):
		is_muted = SaveManager.get_mute_state()
	
	# Start playing the first track (if not muted)
	play_music()
	
	print("AudioManager: Music and SFX system initialized")

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

# Sound Effects Functions (not affected by music mute)
func play_jump_sound():
	if jump_sound and jump_sfx_player:
		jump_sfx_player.stream = jump_sound
		jump_sfx_player.play()
		print("AudioManager: Playing jump sound")

func play_coin_sound():
	if coin_sound and coin_sfx_player:
		coin_sfx_player.stream = coin_sound
		coin_sfx_player.play()
		print("AudioManager: Playing coin sound")

func play_damage_sound():
	if damage_sound and damage_sfx_player:
		damage_sfx_player.stream = damage_sound
		damage_sfx_player.play()
		print("AudioManager: Playing damage sound")

func play_checkpoint_sound():
	if checkpoint_sound and checkpoint_sfx_player:
		checkpoint_sfx_player.stream = checkpoint_sound
		checkpoint_sfx_player.play()
		print("AudioManager: Playing checkpoint sound")
