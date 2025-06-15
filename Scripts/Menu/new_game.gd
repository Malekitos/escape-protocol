extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")
	const BUTTON = preload("res://sounds/button.mp3")
	GlobalSFX.play(BUTTON)


func _on_create_pressed() -> void:
	const BUTTON = preload("res://sounds/button.mp3")
	GlobalSFX.play(BUTTON)
	var world_name : String = $NinePatchRect/MarginContainer/VBoxContainer/LineEdit.text
	if world_name == "":
		world_name = "World: Undefined"
	SceneManager.world_name = world_name
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/loading_screen.tscn")
	#SceneManager.create_game(world_name)
	
