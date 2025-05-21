extends Node

var player_scene: PackedScene = preload("res://Scenes/player.tscn")
var player: Node2D
var main_scene: Node
var player_place: Node
var world_place: Node
var saved_level: Node2D
var menu_scene: PackedScene = preload("res://Scenes/Menu_Scenes/menu.tscn")

func exit_game():
	
	save_node_to_file(player_place, "res://saves/player_place.tscn")
	save_node_to_file(world_place, "res://saves/world_place.tscn")
	
	
	get_tree().change_scene_to_packed(menu_scene)

func _ready() -> void:
	get_tree().change_scene_to_packed(menu_scene)
	
func create_game(world_name : String):
	
	delete_save_files()
	var new_scene = preload("res://Scenes/main.tscn").instantiate()
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene

	main_scene = new_scene
	player_place = main_scene.get_node("playerPlace")
	world_place = main_scene.get_node("worldPlace")

	player = player_scene.instantiate()
	player_place.add_child(player)

	set_level(preload("res://Scenes/proc_gen_world.tscn"), false)


func set_level(world, save : bool):
	if save:
		world_place.add_child(saved_level)
	else:
		var new_level = world.instantiate()
		world_place.add_child(new_level)

		
func clear_level(save : bool):
	for child in world_place.get_children():
		if save:
			saved_level = child
		world_place.remove_child(child)
		
			
func save_node_to_file(node: Node, file_path: String) -> void:
	var packed_scene := PackedScene.new()
	if packed_scene.pack(node) != OK:
		print("Не удалось упаковать узел:", node.name)
		return
	if ResourceSaver.save(packed_scene,file_path) != OK:
		print("Ошибка сохранения:", file_path)
	else:
		print("Узел сохранён:", file_path)

func delete_save_files():
	var save_dir_path = "res://saves/"
	if not DirAccess.dir_exists_absolute(save_dir_path):
		print("Папки нет — ничего удалять не нужно.")
		return

	var dir = DirAccess.open(save_dir_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var file_path = save_dir_path + file_name
				DirAccess.remove_absolute(file_path)
				print("Удалён файл:", file_path)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Не удалось открыть папку сохранений.")
