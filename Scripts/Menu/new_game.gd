extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")



func _on_create_pressed() -> void:
	SceneManager.create_game()
	
