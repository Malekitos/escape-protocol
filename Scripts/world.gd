extends Node2D

@onready var tile_map = $TileMap

var ground_layer = 1
var enviroment_layer = 2
var can_place_custom_data = "can_place"

func _ready() -> void:
	pass # Replace with function body.


func _input(_event):
	if Input.is_action_pressed("click"):
		
		var mouse_position = get_global_mouse_position()
		var tile_mouse_pos = tile_map.local_to_map(mouse_position)
		var source_id = 0
		var atlas_coord = Vector2i(11,1)
		var tile_data = tile_map.get_cell_tile_data(ground_layer, tile_mouse_pos)

		if tile_data:
			var can_place = tile_data.get_custom_data(can_place_custom_data)
			if can_place:
				tile_map.set_cell(enviroment_layer, tile_mouse_pos, source_id, atlas_coord)


		
