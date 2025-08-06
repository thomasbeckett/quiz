extends Node2D
@onready var label_2: Label = $CanvasLayer/Label2
@onready var button: Button = $CanvasLayer/Button
@onready var button_2: Button = $CanvasLayer/Button2

func _ready() -> void:
	label_2.text = "You answered " + str(game_state.answeredQuestions.size()) + " total questions, with " + str(game_state.totalCorrectAnswers) + " questions answered correctly."
	button.pressed.connect(_on_restart_button_pressed)
	button_2.pressed.connect(_on_stats_button_pressed)
	if Stats.least_questions_to_win == -1 or Stats.least_questions_to_win > game_state.answeredQuestions.size():
		Stats.least_questions_to_win = game_state.answeredQuestions.size()
	Stats.total_games_played += 1
	Stats.save()

func _on_restart_button_pressed() -> void:
	game_state.answeredQuestions.clear()
	game_state.currentQuestionCategory = ""
	game_state.correctAnswerCount = 0
	var category_keys = game_state.CATEGORIES.keys()
	var random_key = category_keys[randi() % category_keys.size()]
	game_state.currentQuestionCategory = game_state.CATEGORIES[random_key]
	get_tree().change_scene_to_file("res://question.tscn")

func _on_stats_button_pressed() -> void:
	get_tree().change_scene_to_file("res://stats.tscn")
