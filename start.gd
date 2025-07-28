extends Node2D
@onready var button: Button = $CanvasLayer/Button

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# Get all category keys as an array
	var category_keys = game_state.CATEGORIES.keys()
	# Pick a random key
	var random_key = category_keys[randi() % category_keys.size()]
	# Get the file path if needed
	game_state.currentQuestionCategory = game_state.CATEGORIES[random_key]
	get_tree().change_scene_to_file("res://question.tscn")
