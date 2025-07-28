extends Node2D

@onready var cat_opt_1: Button = $CanvasLayer/VBoxContainer/GridContainer/CatOpt1
@onready var cat_opt_2: Button = $CanvasLayer/VBoxContainer/GridContainer/CatOpt2
@onready var current_cat: Label = $CanvasLayer/VBoxContainer/CurrentCat
@onready var label: Label = $CanvasLayer/Label

func _ready() -> void:
	cat_opt_1.pressed.connect(_on_cat_opt_pressed.bind(cat_opt_1))
	cat_opt_2.pressed.connect(_on_cat_opt_pressed.bind(cat_opt_2))

	label.text = "Progress: " + str(game_state.correctAnswerCount) + "/" + str(game_state.winning_score)
	
	# Set the current category label
	current_cat.text = "Current category: " + game_state.get_category_key_from_path(game_state.currentQuestionCategory)
	# Get random category options
	var category_keys = game_state.CATEGORIES.keys()
	var random_keys = []
	while random_keys.size() < 2:
		var random_key = category_keys[randi() % category_keys.size()]
		if random_key not in random_keys:
			random_keys.append(random_key)
	# Set the button texts to the random categories
	cat_opt_1.text = random_keys[0]
	cat_opt_2.text = random_keys[1]

func _on_cat_opt_pressed(button: Button) -> void:
	game_state.currentQuestionCategory = game_state.CATEGORIES[button.text]
	get_tree().change_scene_to_file("res://question.tscn")
