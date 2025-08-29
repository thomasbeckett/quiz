extends Node2D
@onready var label: Label = $CanvasLayer/TextureRect/VBoxContainer/Label
@onready var label_2: Label = $CanvasLayer/TextureRect/VBoxContainer/Label2
@onready var label_3: Label = $CanvasLayer/TextureRect/VBoxContainer/Label3
@onready var label_4: Label = $CanvasLayer/TextureRect/VBoxContainer/Label4
@onready var label_5: Label = $CanvasLayer/TextureRect/VBoxContainer/Label5
@onready var label_7: Label = $CanvasLayer/TextureRect/VBoxContainer/Label7
@onready var label_6: Label = $CanvasLayer/TextureRect/VBoxContainer/Label6

func _ready() -> void:
	label.text = "Total games played: " + str(Stats.total_games_played)
	label_2.text = "Most winning points: " +  ("N/A" if Stats.most_points == -1 else str(Stats.most_points))
	label_7.text = "Total correct answers: " +  ("N/A" if Stats.get_total_correct_answers() == -1 else str(Stats.get_total_correct_answers()))
	label_6.text = "Total incorrect answers: " +  ("N/A" if Stats.get_total_incorrect_answers() == -1 else str(Stats.get_total_incorrect_answers()))
	label_3.text = "Best category: " + ("N/A" if Stats.get_best_category() == "" else Stats.get_best_category())
	label_4.text = "Worst category: " + ("N/A" if Stats.get_worst_category() == "" else Stats.get_worst_category())
	label_5.text = "Favourite category: " + ("N/A" if Stats.get_favourite_category() == "" else Stats.get_favourite_category())
