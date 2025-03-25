extends Node2D

var tree_scene = preload("res://Resources/tree/tree.tscn")

func _ready() -> void:
	var tree = tree_scene.instantiate()
	tree.stats = preload("res://Resources/tree/fall_tree.tres")
	tree.global_position = (Vector2i(200,200))
	add_child(tree)
