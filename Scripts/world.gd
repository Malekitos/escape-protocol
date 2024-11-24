extends Node2D

@onready var tile_map = $TileMap

var enviroment_layer = 2

func _ready() -> void:
	pass # Replace with function body.


func _input(_event):
	if Input.is_action_just_pressed("click"):
		
		var mouse_position = get_global_mouse_position()
		var tile_mouse_pos = tile_map.local_to_map(mouse_position)
		var source_id = 0
		var atlas_coord = Vector2i(11,1)

		tile_map.set_cell(enviroment_layer, tile_mouse_pos, source_id, atlas_coord)
