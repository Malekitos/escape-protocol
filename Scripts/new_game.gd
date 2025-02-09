extends Button

func _on_pressed() -> void:
	$Window.visible = true
	$"../../Background2".visible = true
	
	

func _on_window_close_requested() -> void:
	$Window.visible = false
	$"../../Background2".visible = false


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/proc_gen_world.tscn")
