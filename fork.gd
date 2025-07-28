extends Node2D

@onready var cat_opt_1: Button = $CanvasLayer/VBoxContainer/GridContainer/CatOpt1
@onready var cat_opt_2: Button = $CanvasLayer/VBoxContainer/GridContainer/CatOpt2
@onready var current_cat: Label = $CanvasLayer/VBoxContainer/CurrentCat
@onready var label: Label = $CanvasLayer/Label
@onready var texture_rect: TextureRect = $CanvasLayer/TextureRect

var CATEGORY_COLORS = {
	"Science": Color(0.2, 0.4, 0.6),
	"Sports": Color(0.5, 0.2, 0.5),
	"History": Color(0.6, 0, 0.1),
	"Film and TV": Color(0.9, 0.6, 0.3),
	"Geography": Color(0, 0.3, 0.1),
	"Music":   Color(0.6, 0.5, 0),
	"General": Color(0.5, 0.2, 0.9),
	"Food and drink": Color(0.9, 0.3, 0),
}

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
	_color_button(cat_opt_1, random_keys[0])
	_color_button(cat_opt_2, random_keys[1])

	var color1 = CATEGORY_COLORS.get(random_keys[0], Color(0.8, 0.8, 0.8))
	var color2 = CATEGORY_COLORS.get(random_keys[1], Color(0.8, 0.8, 0.8))

	

	var gradient = Gradient.new()
	gradient.add_point(0.0, color1)
	gradient.add_point(1.0, color2)
	gradient.set_offset(0, 0.0)
	gradient.set_color(0, color1)
	gradient.set_offset(1, 1.0)
	gradient.set_color(1, color2)
	var grad_tex = GradientTexture2D.new()
	grad_tex.gradient = gradient
	grad_tex.fill = GradientTexture2D.FILL_LINEAR
	grad_tex.set_fill_from(Vector2(0.5, 0))
	grad_tex.set_fill_to(Vector2(0.5, 1))
	texture_rect.texture = grad_tex

func _on_cat_opt_pressed(button: Button) -> void:
	game_state.currentQuestionCategory = game_state.CATEGORIES[button.text]
	get_tree().change_scene_to_file("res://question.tscn")

func _color_button(btn: Button, category_key: String) -> void:
	var base_stylebox = btn.get_theme_stylebox("normal") as StyleBoxFlat
	var pressed_stylebox = btn.get_theme_stylebox("pressed") as StyleBoxFlat
	var hover_stylebox = btn.get_theme_stylebox("hover") as StyleBoxFlat
	var stylebox: StyleBoxFlat = base_stylebox.duplicate() if base_stylebox else StyleBoxFlat.new()
	var pressed_box: StyleBoxFlat = pressed_stylebox.duplicate() if pressed_stylebox else StyleBoxFlat.new()
	var hover_box: StyleBoxFlat = hover_stylebox.duplicate() if hover_stylebox else StyleBoxFlat.new()

	stylebox.bg_color = CATEGORY_COLORS.get(category_key, Color(0.8, 0.8, 0.8))
	pressed_box.bg_color = stylebox.bg_color.darkened(0.3)
	hover_box.bg_color = stylebox.bg_color.lightened(0.2)

	btn.add_theme_stylebox_override("normal", stylebox)
	btn.add_theme_stylebox_override("pressed", pressed_box)
	btn.add_theme_stylebox_override("hover", hover_box)
	btn.add_theme_stylebox_override("disabled", stylebox.duplicate())
