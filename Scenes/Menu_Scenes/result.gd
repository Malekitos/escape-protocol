extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var nine_patch_rect: NinePatchRect = $CanvasLayer/NinePatchRect
@onready var go_menu: Button = $CanvasLayer/NinePatchRect/VBoxContainer/go_menu
@onready var result_label: Label = $CanvasLayer/NinePatchRect/VBoxContainer/result_label
@onready var world_label: Label = $CanvasLayer/NinePatchRect/VBoxContainer/world_label


func _ready() -> void:
	var time : String = SceneManager.time
	var world_name : String = SceneManager.world_name
	var minutes_ingame : int = SceneManager.minutes_ingame
	result_label.text = time
	world_label.text = world_name
	
	var file = FileAccess.open("res://saves/result.bin", FileAccess.WRITE)
	file.store_var({
		"world_name" : world_name,
		"world_time" : time,
		"minutes_ingame" : minutes_ingame
	}, true)

func _on_go_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")
