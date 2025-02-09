extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var noise_tree_text : NoiseTexture2D


@onready var tile_map = $TileMap
var noise
var tree_noise

#var noise_val_arr = []


var water_atlas = Vector2i(0,1)
var tree_atlas = Vector2i(15,6)

var sand_tiles_arr = []
var grass_tiles_arr = []

var terrain_sand_int = 0
var terrain_grass_int = 1

var water_layer = 0
var ground_layer = 1
var ground2_layer = 2
var enviroment_layer = 3
var cliff_layer_layer = 4



var source_id = 0

var width = 300
var height = 300

func _ready() -> void:
	noise = noise_height_text.noise
	tree_noise = noise_tree_text.noise

	generate_world()


func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			var tree_noise_val = tree_noise.get_noise_2d(x,y)

			#noise_val_arr.append(noise_val)
			
			if noise_val > 0.0:
				if noise_val > 0.2:
					grass_tiles_arr.append(Vector2i(x,y))

				sand_tiles_arr.append(Vector2i(x,y))
				if tree_noise_val >0.9 and noise_val > 0.2:
					tile_map.set_cell(enviroment_layer, Vector2i(x,y),source_id, tree_atlas)
				
			tile_map.set_cell(water_layer, Vector2i(x,y),source_id, water_atlas)
	
	tile_map.set_cells_terrain_connect(ground_layer, sand_tiles_arr, terrain_sand_int, 0)
	tile_map.set_cells_terrain_connect(ground_layer, grass_tiles_arr, terrain_grass_int, 0)




	#print("Highest: ", noise_val_arr.max())
	#print("lowest: ", noise_val_arr.min())


func _process(_delta: float) -> void:
	pass
