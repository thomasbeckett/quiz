extends Node2D
@onready var button: Button = $CanvasLayer/VBoxContainer/Button
@onready var button_2: Button = $CanvasLayer/VBoxContainer/Button2
@onready var button_3: Button = $CanvasLayer/VBoxContainer/Button3

func _ready() -> void:
	Stats.load()
	game_state.correctAnswerCount = 0
	game_state.answeredQuestions.clear()
	game_state.currentQuestionCategory = ""
	game_state.totalCorrectAnswers = 0
	button.pressed.connect(_on_button_pressed)
	button_2.pressed.connect(_on_category_pressed)
	button_3.pressed.connect(_on_stats_pressed)

func _on_button_pressed() -> void:
	game_state.single_category_mode = false
	# Get all category keys as an array
	var category_keys = game_state.CATEGORIES.keys().filter(func(key): return key != "Ilaria")
	# Pick a random key
	var random_key = category_keys[randi() % category_keys.size()]
	# Get the file path if needed
	game_state.currentQuestionCategory = game_state.CATEGORIES[random_key]
	get_tree().change_scene_to_file("res://question.tscn")

func _on_category_pressed() -> void:
	get_tree().change_scene_to_file("res://category_selector.tscn")

func _on_stats_pressed() -> void:
	get_tree().change_scene_to_file("res://stats.tscn")
