extends Node2D

var tree_scene = preload("res://Resources/tree/tree.tscn")
var rock_scene = preload("res://Resources/Rocks/rock.tscn")

func _ready() -> void:
	var tree = tree_scene.instantiate()
	tree.stats = preload("res://Resources/tree/fall_tree.tres")
	tree.global_position = (Vector2i(200,200))
	
	
	var rock = rock_scene.instantiate()
	rock.stats = preload("res://Resources/Rocks/winter_stone.tres")
	rock.global_position = (Vector2i(300,300))
	
	
	add_child(rock)
	add_child(tree)
