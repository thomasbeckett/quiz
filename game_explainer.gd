extends Node2D
@onready var button_4: Button = $CanvasLayer/Button4

func _ready() -> void:
	button_4.pressed.connect(_on_button_pressed)
	Stats.explainer_shown = true
	Stats.save()
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://question.tscn")
