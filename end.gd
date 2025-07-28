extends Node2D
@onready var label_2: Label = $CanvasLayer/Label2
@onready var button: Button = $CanvasLayer/Button

func _ready() -> void:
	label_2.text = "You answered " + str(game_state.answeredQuestions.size()) + " total questions, with " + str(game_state.totalCorrectAnswers) + " questions answered correctly."
	button.pressed.connect(_on_restart_button_pressed)

func _on_restart_button_pressed() -> void:
	game_state.answeredQuestions.clear()
	game_state.currentQuestionCategory = ""
	game_state.correctAnswerCount = 0
	var category_keys = game_state.CATEGORIES.keys()
	var random_key = category_keys[randi() % category_keys.size()]
	game_state.currentQuestionCategory = game_state.CATEGORIES[random_key]
	get_tree().change_scene_to_file("res://question.tscn")
