extends Node2D
@onready var label: Label = $CanvasLayer/TextureRect/VBoxContainer/Label
@onready var label_2: Label = $CanvasLayer/TextureRect/VBoxContainer/Label2
@onready var label_3: Label = $CanvasLayer/TextureRect/VBoxContainer/Label2
@onready var label_4: Label = $CanvasLayer/TextureRect/VBoxContainer/Label4

func _ready() -> void:
	label.text = "Total Games Played: " + str(Stats.total_games_played)
	label_2.text = "Least Questions to Win: " + str(Stats.least_questions_to_win)
	label_4.text = "Favourite Category: " + Stats.get_favourite_category()
