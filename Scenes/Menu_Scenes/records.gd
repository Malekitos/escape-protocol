extends Control

@onready var h_box_container: HBoxContainer = $NinePatchRect/VBoxContainer/HBoxContainer
@onready var v_box_container: VBoxContainer = $NinePatchRect/VBoxContainer

func _ready() -> void:
	
	var records = load_records()
	
	for i in load_records().size():
		var row = h_box_container.duplicate()
		
		var time_label = row.get_node("time_label")
		var world_label = row.get_node("world_label")
		
		time_label.text = records[i]["world_time"]
		world_label.text = records[i]["world_name"]
		v_box_container.add_child(row)
		
	#h_box_container.hide()
	
func load_records():
	var save_path = "user://saves/saveResults.json"
	var result : Array
	
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var content = file.get_as_text()
		result = JSON.parse_string(content)
		
	return result
		

func _on_back_pressed() -> void:
	const BUTTON = preload("res://sounds/button.mp3")
	GlobalSFX.play(BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")
