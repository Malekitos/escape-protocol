extends Control

@onready var music_slider: HSlider = $NinePatchRect/VBoxContainer/HBoxContainer2/music_slider
@onready var volume_slider: HSlider = $NinePatchRect/VBoxContainer/HBoxContainer/volume_slider


func _ready():
	
	if FileAccess.file_exists("user://volume_music.txt"):
		var f = FileAccess.open("user://volume_music.txt", FileAccess.READ)
		var value = f.get_float()
		music_slider.value = value
		MusicManager.set_volume(value)


	if FileAccess.file_exists("user://volume_sfx.txt"):
		var f = FileAccess.open("user://volume_sfx.txt", FileAccess.READ)
		var value = f.get_float()
		volume_slider.value = value
		GlobalSFX.set_volume(value)  

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/menu.tscn")


func _on_volume_slider_value_changed(value: float) -> void:
	GlobalSFX.set_volume(value)
	var f = FileAccess.open("user://volume_sfx.txt", FileAccess.WRITE)
	f.store_float(value)

func _on_music_slider_value_changed(value: float) -> void:
	MusicManager.set_volume(value)
	var f = FileAccess.open("user://volume_music.txt", FileAccess.WRITE)
	f.store_float(value)
