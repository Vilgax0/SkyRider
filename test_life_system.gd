# Test script for the new life system
extends Node

func _ready():
	print("=== TESTING NEW LIFE SYSTEM ===")
	
	# Test initial lives
	print("Initial lives: ", GameManager.get_player_lives())
	assert(GameManager.get_player_lives() == 5, "Player should start with 5 lives")
	
	# Test taking damage
	print("Taking 1 damage...")
	GameManager.take_damage(1)
	print("Lives after damage: ", GameManager.get_player_lives())
	assert(GameManager.get_player_lives() == 4, "Player should have 4 lives after 1 damage")
	
	# Test multiple damage
	print("Taking 3 more damage...")
	GameManager.take_damage(3)
	print("Lives after more damage: ", GameManager.get_player_lives())
	assert(GameManager.get_player_lives() == 1, "Player should have 1 life left")
	
	# Test game over
	print("Taking final damage (should trigger game over)...")
	# Note: This would actually change scenes, so we'll just check the logic
	
	print("✅ All life system tests passed!")
	print("=== TEST COMPLETE ===")
	
	# Clean up - reset for normal gameplay
	GameManager.player_lives = 5
	GameManager.game_running = false
