extends Node

@onready var player_scene: PackedScene = preload("res://Scenes/player.tscn")
@onready var player = player_scene.instantiate()



@onready var main_scene = get_tree().current_scene
@onready var player_place = main_scene.get_node("playerPlace")
@onready var world_place = main_scene.get_node("worldPlace")

var saved_level : Node2D

func _ready():
	
	

	
	set_level(preload("res://Scenes/proc_gen_world.tscn"), false)
	#set_level(preload("res://Scenes/test_world.tscn"), false)

	player_place.add_child(player)


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
			
			

	
