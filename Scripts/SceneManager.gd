extends Node

@onready var player_scene: PackedScene = preload("res://Scenes/player.tscn")
@onready var player = player_scene.instantiate()



@onready var main_scene = get_tree().current_scene
@onready var player_place = main_scene.get_node("playerPlace")
@onready var world_place = main_scene.get_node("worldPlace")


func _ready():
	
	var new_level = preload("res://Scenes/proc_gen_world.tscn").instantiate()
	
	set_level(preload("res://Scenes/proc_gen_world.tscn"))
	
	player_place.add_child(player)


func set_level(world):

		var new_level = world.instantiate()
		world_place.add_child(new_level)
		
func clear_level():
	for child in world_place.get_children():
			world_place.remove_child(child)
