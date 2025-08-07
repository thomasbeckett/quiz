extends Node2D
@onready var button: Button = $CanvasLayer/VBoxContainer/Button
@onready var button_2: Button = $CanvasLayer/VBoxContainer/Button2
@onready var button_3: Button = $CanvasLayer/VBoxContainer/Button3
@onready var button_4: Button = $CanvasLayer/VBoxContainer/Button4
@onready var fifty_fifty_button: Button = $CanvasLayer/GridContainer/fifty_fifty_button
@onready var free_skip_button: Button = $CanvasLayer/GridContainer/free_skip_button
@onready var reroll_button: Button = $CanvasLayer/GridContainer/reroll_button

func _ready() -> void:
	Stats.load()
	game_state.load_progress()
	game_state.correctAnswerCount = 0
	game_state.answeredQuestions.clear()
	game_state.currentQuestionCategory = ""
	game_state.totalCorrectAnswers = 0
	if game_state.progression_stage > 0:
		button.text = "Continue"
		button.add_theme_font_size_override("font_size", 65)
		button_4.visible = true
		button_4.pressed.connect(_on_new_game_pressed)
	else:
		button.text = "Start"
		button.add_theme_font_size_override("font_size", 100)
		button_4.visible = false
	button.pressed.connect(_on_button_pressed)
	button_2.pressed.connect(_on_category_pressed)
	button_3.pressed.connect(_on_stats_pressed)

func _on_button_pressed() -> void:
	game_state.single_category_mode = false
	if game_state.unlockable:
		get_tree().change_scene_to_file("res://add_category.tscn")
		return
	# Get all category keys as an array
	var available_categories = game_state.unlocked_categories
	var category_keys = game_state.CATEGORIES.keys().filter(func(key): return key != "Ilaria").filter(func(key): return key in available_categories)
	# Pick a random key
	var random_key = category_keys[randi() % category_keys.size()]
	# Get the file path if needed
	game_state.currentQuestionCategory = game_state.CATEGORIES[random_key]
	Stats.total_games_played += 1
	Stats.save()
	get_tree().change_scene_to_file("res://question.tscn")

func _on_category_pressed() -> void:
	get_tree().change_scene_to_file("res://category_selector.tscn")

func _on_stats_pressed() -> void:
	get_tree().change_scene_to_file("res://stats.tscn")

func _on_new_game_pressed() -> void:
	# Reset all progress
	game_state.reset_progress()
	_on_button_pressed()
