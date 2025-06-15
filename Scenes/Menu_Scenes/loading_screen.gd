extends Control

@onready var progress_bar: ProgressBar = $NinePatchRect/MarginContainer/VBoxContainer/ProgressBar
@onready var label: Label = $NinePatchRect/MarginContainer/VBoxContainer/Label

var progress = [0.0]
var SceneName
var scene_load_status = 0

func _ready() -> void:
	SceneName = "res://Scenes/proc_gen_world.tscn"
	ResourceLoader.load_threaded_request(SceneName)
	
func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(SceneName,progress)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(SceneName)
		SceneManager.create_game(newScene)
