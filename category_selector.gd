extends Node2D
@onready var cat_opt_1: Button = $CanvasLayer/ScrollContainer/VBoxContainer2/GridContainer/CatOpt1
@onready var grid_container: GridContainer = $CanvasLayer/ScrollContainer/VBoxContainer2/GridContainer

func _ready() -> void:
	# Remove the template button from the scene (we'll use it as a template)
	cat_opt_1.visible = false

	# Get all categories except "Ilaria"
	var category_keys = game_state.CATEGORIES.keys()
	for category in category_keys:
		var btn = cat_opt_1.duplicate()
		btn.visible = true
		btn.text = category
		btn.pressed.connect(_on_category_button_pressed.bind(category))
		grid_container.add_child(btn)

func _on_category_button_pressed(category: String) -> void:
	game_state.currentQuestionCategory = game_state.CATEGORIES[category]
	game_state.single_category_mode = true
	get_tree().change_scene_to_file("res://question.tscn")
