extends Node

var answeredQuestions: Array = []
var currentQuestionCategory: String = ""
var currentQuestionId: String = ""
var correctAnswerCount: int = 0
var totalCorrectAnswers: int = 0
var single_category_mode: bool = false

const CATEGORIES = {
	"Science": "res://questions/science.json",
	"Sports": "res://questions/sports.json",
	"History": "res://questions/history.json",
	"Film and TV": "res://questions/film_and_tv.json",
	"Geography": "res://questions/geography.json",
	"Music": "res://questions/music.json",
	"General": "res://questions/general.json",
	"Food and drink": "res://questions/food_and_drink.json",
	"Ilaria": "res://questions/ilaria.json"
}

var unlocked_categories: Array = ["General"]
var progression_stage: int = 0
var winning_score = 1
var unlockable = false;
var coins = 0
var fifty_fiftys = 10
var free_skips = 10
var reroll_categories = 10
var reroll_questions = 10
var double_points = 10
var double_points_active = false


func unlock_categories(new_categories: Array):
	for cat in new_categories:
		if cat not in unlocked_categories:
			unlocked_categories.append(cat)

func advance_progression():
	progression_stage += 1
	winning_score += 2


func get_category_key_from_path(path: String) -> String:
	for key in CATEGORIES.keys():
		if CATEGORIES[key] == path:
			return key
	return ""

func save_progress():
	var file = FileAccess.open("user://progress.json", FileAccess.WRITE)
	if file:
		var data = {
			"unlocked_categories": unlocked_categories,
			"progression_stage": progression_stage,
			"winning_score": winning_score,
			"unlockable": unlockable
		}
		file.store_string(JSON.stringify(data))
		file.close()

func load_progress():
	if FileAccess.file_exists("user://progress.json"):
		var file = FileAccess.open("user://progress.json", FileAccess.READ)
		if file:
			var data = file.get_as_text()
			var parsed = JSON.parse_string(data)
			if typeof(parsed) == TYPE_DICTIONARY:
				unlocked_categories = parsed.get("unlocked_categories", ["General"])
				progression_stage = parsed.get("progression_stage", 0)
				winning_score = parsed.get("winning_score", 5)
				unlockable = parsed.get("unlockable", false)
			file.close()

func reset_progress():
	unlocked_categories = ["General"]
	progression_stage = 0
	winning_score = 1
	unlockable = false
	save_progress()
