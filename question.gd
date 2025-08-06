extends Node2D
@onready var button_2: Button = $CanvasLayer/VBoxContainer/Button2
@onready var label: Label = $CanvasLayer/Label
@onready var v_box_container: VBoxContainer = $CanvasLayer/VBoxContainer
@onready var button_3: Button = $CanvasLayer/Button3
@onready var background_rect: TextureRect = $CanvasLayer/TextureRect

var incorrect_answers: Array
var correct_answer: String
var question: String

var CATEGORY_GRADIENT_PATHS = {
	"Science": "res://gradients/science_gradient.tres",
	"Sports": "res://gradients/sports_gradient.tres",
	"History": "res://gradients/history_gradient.tres",
	"Film and TV": "res://gradients/music_gradient.tres",
	"Geography": "res://gradients/geography_gradient.tres",
	"Music": "res://gradients/music_gradient.tres",
	"General": "res://gradients/general_gradient.tres",
	"Food and drink": "res://gradients/food_gradient.tres",
}

var CATEGORY_BUTTON_COLORS = {
	"Science": Color(0.2, 0.4, 0.6),
	"Sports": Color(0.5, 0.2, 0.5),
	"History": Color(0.6, 0, 0.1),
	"Film and TV": Color(0.8, 0.5, 0.1),
	"Geography": Color(0, 0.3, 0.1),
	"Music":   Color(0.7, 0.5, 0),
	"General": Color(0.5, 0.2, 0.9),
	"Food and drink": Color(0.9, 0.3, 0),
	"Ilaria": Color(0.6, 0, 0.1) 
}
 
func _ready() -> void:
	print("Current Question Category: ", game_state.get_category_key_from_path(game_state.currentQuestionCategory))
	button_3.pressed.connect(_on_next_button_pressed)
	var file = FileAccess.open(game_state.currentQuestionCategory, FileAccess.READ)
	var questions = []
	if file:
		var json = file.get_as_text()
		var parsed = JSON.parse_string(json)
		if typeof(parsed) == TYPE_ARRAY:
			questions = parsed
		file.close()

	if questions.size() == 0:
		label.text = "No questions found."
		return
	questions = questions.filter(func(q):
		return not game_state.answeredQuestions.has(q.id)
	)
	if questions.size() == 0:
		game_state.answeredQuestions.clear()
		# Reload all questions
		var file2 = FileAccess.open(game_state.currentQuestionCategory, FileAccess.READ)
		if file2:
			var json2 = file2.get_as_text()
			var parsed2 = JSON.parse_string(json2)
			if typeof(parsed2) == TYPE_ARRAY:
				questions = parsed2
			file2.close()
		print("All answers in category have been answered.")
	var random_index = randi() % questions.size()
	var selected_question = questions[random_index]
	game_state.currentQuestionId = selected_question.id
	label.text = selected_question.question.text
	incorrect_answers = selected_question.incorrectAnswers
	correct_answer = selected_question.correctAnswer
	var answers: Array = incorrect_answers
	answers.append(correct_answer)
	answers.shuffle()
	var category_key = game_state.get_category_key_from_path(game_state.currentQuestionCategory)
	for answer in answers:
		var btn = button_2.duplicate(true)
		btn.text = answer
		var base_stylebox = btn.get_theme_stylebox("normal") as StyleBoxFlat
		var pressed_stylebox = btn.get_theme_stylebox("pressed") as StyleBoxFlat
		var hover_stylebox = btn.get_theme_stylebox("hover") as StyleBoxFlat
		var stylebox: StyleBoxFlat
		if base_stylebox:
			stylebox = base_stylebox.duplicate()
		else:
			stylebox = StyleBoxFlat.new()
		# Set the button color based on the category
		stylebox.bg_color = CATEGORY_BUTTON_COLORS.get(category_key, Color(0.8, 0.8, 0.8))
		stylebox.border_color =  stylebox.bg_color.darkened(0.4)
		pressed_stylebox.bg_color = stylebox.bg_color.darkened(0.2)
		pressed_stylebox.border_color = stylebox.border_color.darkened(0.3)
		hover_stylebox.bg_color = stylebox.bg_color.lightened(0.2)
		hover_stylebox.border_color = stylebox.border_color.lightened(0.2)
		btn.add_theme_stylebox_override("normal", stylebox)
		btn.add_theme_stylebox_override("disabled", stylebox.duplicate())
		btn.pressed.connect(_on_button_pressed.bind(btn))
		v_box_container.add_child(btn)
	button_2.queue_free()
	
	var gradient_path = CATEGORY_GRADIENT_PATHS.get(category_key, "")
	print("Gradient Path: ", gradient_path)
	if gradient_path != "":
		print("Loading gradient from: ", gradient_path)
		var grad_res = load(gradient_path)
		if not grad_res:
			print("Failed to load gradient resource.")
			return
		# var grad_tex = background_rect.texture as GradientTexture2D
		# if grad_tex and grad_res:
			print("Setting gradient texture.")
		background_rect.texture = grad_res

func _on_button_pressed(button: Button) -> void:
	var style := button.get_theme_stylebox("disabled") as StyleBoxFlat
	if button.text == correct_answer:
		label.text = "Correct!"
		style.bg_color = Color(0, 1, 0) # Green
		game_state.correctAnswerCount += 1
		game_state.totalCorrectAnswers += 1
	else:
		label.text = "Incorrect. Try again."
		style.bg_color = Color(1, 0, 0) # Red
		if game_state.correctAnswerCount > 0:
			game_state.correctAnswerCount -= 1
		# game_state.correctAnswerCount -= 1
		for child in v_box_container.get_children():
			if child is Button:
				if child.text == correct_answer:
					var correct_style := child.get_theme_stylebox("disabled") as StyleBoxFlat
					correct_style.bg_color = Color(0, 1, 0) # Green
	button.add_theme_stylebox_override("disabled", style)

	for child in v_box_container.get_children():
		if child is Button:
			child.disabled = true

	button_3.visible = true

func _on_next_button_pressed() -> void:
	print("Correct Answer Count: ", game_state.correctAnswerCount)
	game_state.answeredQuestions.append(
		game_state.currentQuestionId
	)
	if game_state.correctAnswerCount >= game_state.winning_score:
		get_tree().change_scene_to_file("res://end.tscn")
		return
	if game_state.single_category_mode:
		get_tree().change_scene_to_file("res://question.tscn")
		return
	get_tree().change_scene_to_file("res://fork.tscn")
