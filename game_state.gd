extends Node

var answeredQuestions: Array = []
var currentQuestionCategory: String = ""
var currentQuestionId: String = ""
var correctAnswerCount: int = 0
var totalCorrectAnswers: int = 0
var winning_score = 3

const CATEGORIES = {
	"Science": "res://questions/science.json",
	"Sports": "res://questions/sports.json",
	"History": "res://questions/history.json",
	"Film and TV": "res://questions/film_and_tv.json",
	"Geography": "res://questions/geography.json",
	"Music": "res://questions/music.json",
	"General": "res://questions/general.json",
	"Food and drink": "res://questions/food_and_drink.json",
}


func get_category_key_from_path(path: String) -> String:
	for key in CATEGORIES.keys():
		if CATEGORIES[key] == path:
			return key
	return ""
