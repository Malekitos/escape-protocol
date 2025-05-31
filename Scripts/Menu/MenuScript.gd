extends Control
@onready var new_game: Button = $"NinePatchRect/VBoxContainer/New Game"

@onready var ui_audio_player: AudioStreamPlayer = $UIaudioPlayer
const BUTTON = preload("res://sounds/button.mp3")

func _on_exit_pressed() -> void:
	GlobalSFX.play(BUTTON)
	get_tree().quit()


func _on_settings_pressed() -> void:
	GlobalSFX.play(BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/settings.tscn")


func _on_load_game_pressed() -> void:
	GlobalSFX.play(BUTTON)
	SceneManager.continue_game()


func _on_new_game_pressed() -> void:
	GlobalSFX.play(BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/new_game.tscn")


func _on_records_pressed() -> void:
	GlobalSFX.play(BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/records.tscn")


func _on_instruction_pressed() -> void:
	GlobalSFX.play(BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/instructions.tscn")
