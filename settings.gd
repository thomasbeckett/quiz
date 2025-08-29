extends Node2D
@onready var button_5: Button = $CanvasLayer/ColorRect/VBoxContainer/Button5
@onready var button_4: Button = $CanvasLayer/ColorRect/VBoxContainer/Button4

func _ready() -> void:
	button_4.pressed.connect(_on_button_pressed)
	button_5.pressed.connect(_button_5_pressed)

func _on_button_pressed() -> void:
	Stats.reset()
	Stats.save()

func _button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://app_instruction.tscn")
