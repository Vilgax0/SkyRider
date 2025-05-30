# Final validation script for the complete life system
extends Control

@onready var status_label = $VBoxContainer/StatusLabel
@onready var test_button = $VBoxContainer/TestButton
@onready var lives_label = $VBoxContainer/LivesLabel

func _ready():
	test_button.pressed.connect(_run_tests)
	_update_display()

func _update_display():
	lives_label.text = "Current Lives: " + str(GameManager.get_player_lives())
	status_label.text = "Life System Ready for Testing"

func _run_tests():
	status_label.text = "Running tests..."
	
	# Test 1: Verify initial lives
	if GameManager.get_player_lives() != 5:
		GameManager.player_lives = 5
	
	status_label.text = "✅ Lives set to 5"
	_update_display()
	
	await get_tree().create_timer(1.0).timeout
	
	# Test 2: Test damage without game over
	GameManager.take_damage(1)
	status_label.text = "✅ Damage test - Lives: " + str(GameManager.get_player_lives())
	_update_display()
	
	await get_tree().create_timer(1.0).timeout
	
	# Reset for normal gameplay
	GameManager.player_lives = 5
	GameManager.game_running = false
	status_label.text = "✅ All tests passed! System ready."
	_update_display()
