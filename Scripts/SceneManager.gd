extends Node

var player_scene: PackedScene = preload("res://Scenes/player.tscn")
var player: Node2D
var main_scene: Node
var player_place: Node
var world_place: Node
var saved_level: Node2D
var menu_scene: PackedScene = preload("res://Scenes/Menu_Scenes/menu.tscn")

var time : String
var world_name : String
var minutes_ingame : int


func _ready() -> void:
	get_tree().change_scene_to_packed(menu_scene)
	

func exit_game():
	var player_data = get_tree().get_first_node_in_group("player")
	
	if player_data.in_mine:
		player_data.global_position = player_data.player_position
		clear_level(false)
		set_level(preload("res://Scenes/proc_gen_world.tscn"), true)
		player_data.in_mine = false
	
	var player = player_place.get_children()
	var world = world_place.get_children()
	
	var player_node = get_tree().get_nodes_in_group("player")[0]
	var inventory = player_node.get_node('UI/CanvasLayer/AnimationPlayer/Inventory')
	
	inventory.save_inventory()
		
	save_node_to_file(player[0], "res://saves/player_place.tscn")
	save_node_to_file(world[0], "res://saves/world_place.tscn")
	
	get_tree().change_scene_to_packed(menu_scene)


func continue_game():

	var new_scene = preload("res://Scenes/main.tscn").instantiate()
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene


	main_scene = new_scene
	player_place = main_scene.get_node("playerPlace")
	world_place = main_scene.get_node("worldPlace")

	var saved_player = load("res://saves/player_place.tscn").instantiate()
	var saved_world = load("res://saves/world_place.tscn").instantiate()

	saved_world.is_loaded_from_save = true
	
	player_place.add_child(saved_player)
	world_place.add_child(saved_world)
	
	var player_data = get_tree().get_first_node_in_group("player")
	var time_data = get_tree().get_first_node_in_group("time")
	
	var WorldData = load("res://saves/world_data.tres")
		
	time_data.internal_time = WorldData.internal_time
	player_data.health = WorldData.player_health
	world_name = WorldData.world_name
	
	
func create_game(world_name : String):
	if FileAccess.file_exists("res://saves/inventory_data.res"):
		var dir := DirAccess.open("res://saves")
		if dir:
			dir.remove("inventory_data.res")

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

	var player_data = get_tree().get_first_node_in_group("player")
	var time_data = get_tree().get_first_node_in_group("time")

	
	if packed_scene.pack(node) != OK:
		print("Не удалось упаковать узел:", node.name)
		return
	if ResourceSaver.save(packed_scene,file_path) != OK:
		print("Ошибка сохранения:", file_path)

	var WorldData = world_data.new()
	WorldData.internal_time = time_data.internal_time
	WorldData.player_health = player_data.health
	WorldData.world_name = world_name
	
	var WorldDataPath = "res://saves/world_data.tres"
	ResourceSaver.save(WorldData, WorldDataPath)


func spawn_enemy(value) -> void:
	var proc_gen_world = world_place.get_child(0)
	var enemy = preload("res://Resources/Enemys/enemy.tscn").instantiate()
	
	if proc_gen_world.enemy_spawnpoints.pick_random():
		enemy.global_position = (proc_gen_world.enemy_spawnpoints.pick_random())
	
	player_place = main_scene.get_node("playerPlace")
	
	for i in value:
		player_place.add_child(enemy)
	
	
