extends Control


func _on_back_pressed() -> void:
	const BUTTON = preload("res://sounds/button.mp3")
	GlobalSFX.play(BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")
	
