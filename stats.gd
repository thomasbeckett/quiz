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
var categories_correct: Dictionary = {"Science": 0,
	"Sports": 0,
	"History": 0,
	"Film and TV": 0,
	"Geography": 0,
	"Music": 0,
	"General": 0,
	"Food and drink": 0}
var categories_incorrect: Dictionary = {"Science": 0,
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
			"categories_chosen": categories_chosen,
			"categories_correct": categories_correct,
			"categories_incorrect": categories_incorrect
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
				categories_correct = parsed.get("categories_correct", categories_correct)
				categories_incorrect = parsed.get("categories_incorrect", categories_incorrect)
			file.close()

func get_favourite_category() -> String:
	var fav = ""
	var max_count = 0
	for category in categories_chosen.keys():
		if categories_chosen[category] > max_count:
			max_count = categories_chosen[category]
			fav = category
	return fav

func get_best_category() -> String:
	var best = ""
	var max_correct = 0
	for category in categories_correct.keys():
		if categories_correct[category] > max_correct:
			max_correct = categories_correct[category]
			best = category
	return best

func get_worst_category() -> String:
	var worst = ""
	var max_incorrect = 0
	for category in categories_incorrect.keys():
		if categories_incorrect[category] > max_incorrect:
			max_incorrect = categories_incorrect[category]
			worst = category
	return worst
	
func record_category_choice(category: String) -> void:
	if not categories_chosen.has(category):
		categories_chosen[category] = 0
	categories_chosen[category] += 1
	save()

func record_correct_answer(category: String) -> void:
	if not categories_correct.has(category):
		categories_correct[category] = 0
	categories_correct[category] += 1
	save()

func record_incorrect_answer(category: String) -> void:
	if not categories_incorrect.has(category):
		categories_incorrect[category] = 0
	categories_incorrect[category] += 1
	save()
