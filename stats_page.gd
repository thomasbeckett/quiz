extends Node2D
@onready var label: Label = $CanvasLayer/TextureRect/VBoxContainer/Label
@onready var label_2: Label = $CanvasLayer/TextureRect/VBoxContainer/Label2
@onready var label_3: Label = $CanvasLayer/TextureRect/VBoxContainer/Label3
@onready var label_4: Label = $CanvasLayer/TextureRect/VBoxContainer/Label4
@onready var label_5: Label = $CanvasLayer/TextureRect/VBoxContainer/Label5

func _ready() -> void:
	label.text = "Total games played: " + str(Stats.total_games_played)
	label_2.text = "Least questions to win: " +  ("N/A" if Stats.least_questions_to_win == -1 else str(Stats.least_questions_to_win))
	label_3.text = "Best category: " + ("N/A" if Stats.get_best_category() == "" else Stats.get_best_category())
	label_4.text = "Worst category: " + ("N/A" if Stats.get_worst_category() == "" else Stats.get_worst_category())
	label_5.text = "Favourite category: " + ("N/A" if Stats.get_favourite_category() == "" else Stats.get_favourite_category())
