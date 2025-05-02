extends Node

var player_scene: PackedScene = preload("res://Scenes/player.tscn")
var player: Node2D
var main_scene: Node
var player_place: Node
var world_place: Node
var saved_level: Node2D


func create_game():
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
			
			

	
