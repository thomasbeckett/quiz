extends Node

var least_questions_to_win: int = -1
var fastest_time: float = -1.0
var total_games_played: int = 0
var categories_chosen: Dictionary = {"Science": 0,
	"Sports": 0,
	"History": 0,
	"Film and TV": 0,
	"Geography": 0,
	"Music": 0,
	"General": 0,
	"Food and drink": 0}

func save():
	var file = FileAccess.open("user://stats.json", FileAccess.WRITE)
	if file:
		var data = {
			"least_questions_to_win": least_questions_to_win,
			"fastest_time": fastest_time,
			"total_games_played": total_games_played,
			"favourite_category": get_favourite_category(),
			"categories_chosen": categories_chosen
		}
		file.store_string(JSON.stringify(data))
		file.close()

func load():
	if FileAccess.file_exists("user://stats.json"):
		var file = FileAccess.open("user://stats.json", FileAccess.READ)
		if file:
			var data = file.get_as_text()
			var parsed = JSON.parse_string(data)
			if typeof(parsed) == TYPE_DICTIONARY:
				least_questions_to_win = parsed.get("least_questions_to_win", null)
				fastest_time = parsed.get("fastest_time", null)
				total_games_played = parsed.get("total_games_played", 0)
				categories_chosen = parsed.get("categories_chosen", categories_chosen)
			file.close()

func get_favourite_category() -> String:
	var fav = ""
	var max_count = -1
	for category in categories_chosen.keys():
		if categories_chosen[category] > max_count:
			max_count = categories_chosen[category]
			fav = category
	return fav

func record_category_choice(category: String) -> void:
	if not categories_chosen.has(category):
		categories_chosen[category] = 0
	categories_chosen[category] += 1
	save()
