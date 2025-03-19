extends Node2D


var tree_scene = preload("res://Scenes/tree.tscn")

var tree_resources = {
	"winter": preload("res://Resources/tree_stats/winter_tree.tres")
}

func _ready() -> void:
	var tree = tree_scene.instantiate()
	tree.global_position = Vector2i(10,100)
	
	tree.stats = tree_resources["winter"]
	
	add_child(tree)
