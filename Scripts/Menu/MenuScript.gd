extends Control
@onready var new_game: Button = $"NinePatchRect/VBoxContainer/New Game"

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	new_game.pressed.connect(_on_new_game_pressed)



func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/settings.tscn")


func _on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/load_game.tscn")


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/new_game.tscn")
