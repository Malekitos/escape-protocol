extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var nine_patch_rect: NinePatchRect = $CanvasLayer/NinePatchRect
@onready var go_menu: Button = $CanvasLayer/NinePatchRect/VBoxContainer/go_menu
@onready var result_label: Label = $CanvasLayer/NinePatchRect/VBoxContainer/result_label


func _ready() -> void:
	var time : String = SceneManager.time
	result_label.text = time

func _on_go_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")
