# scripts/autoload/SaveManager.gd
extends Node

const SAVE_FILE_PATH = "user://game_data.save"
var game_data = {
	"total_coins": 0,
	"collected_coins": []
}

func _ready():
	load_game()

func save_game():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(game_data)
		file.close()
		print("Game saved successfully")
	else:
		print("Failed to save game")

func load_game():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			game_data = file.get_var()
			file.close()
			print("Game loaded successfully")
		else:
			print("Failed to load game")

func is_coin_collected(coin_id: String) -> bool:
	return coin_id in game_data["collected_coins"]

func collect_coin(coin_id: String):
	if not is_coin_collected(coin_id):
		game_data["collected_coins"].append(coin_id)
		game_data["total_coins"] += 1
		save_game()

func get_total_coins() -> int:
	return game_data["total_coins"]
