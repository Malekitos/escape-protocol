extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var noise_tree_text : NoiseTexture2D


var noise
var tree_noise

#var noise_val_arr = []


var water_atlas = Vector2i(0,1)
var tree_atlas = Vector2i(15,6)

var sand_tiles_arr = []
var grass_tiles_arr = []
var cliff_tiles_arr = []

var terrain_sand_int = 0
var terrain_grass_int = 1
var terrain_cliff_int = 2

@onready var water_layer: TileMapLayer = $water_layer
@onready var ground_layer: TileMapLayer = $ground_layer
@onready var ground_2_layer: TileMapLayer = $ground2_layer
@onready var enviroment_layer: TileMapLayer = $enviroment_layer
@onready var cliffs_layer: TileMapLayer = $cliffs

@onready var player: Node2D = $Player



var grass_atlas_arr = [Vector2i(1,0),Vector2i(2,0),Vector2i(3,0),Vector2i(4,0)]

var source_id = 0

var width = 200
var height = 200

func _ready() -> void:
	noise = noise_height_text.noise
	noise.seed = randi()
	tree_noise = noise_tree_text.noise



	generate_world()



func generate_world():
	
	var player_spawned = false
	
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			var tree_noise_val = tree_noise.get_noise_2d(x,y)

			#noise_val_arr.append(noise_val)
			
			if noise_val > 0.0:
				sand_tiles_arr.append(Vector2i(x,y))
				if noise_val > 0.15:
					grass_tiles_arr.append(Vector2i(x,y))
					
					if noise_val > 0.3:
						ground_2_layer.set_cell(Vector2i(x,y), source_id, grass_atlas_arr.pick_random())
					
					if noise_val > 0.50:
						cliff_tiles_arr.append(Vector2i(x,y))

				
				if tree_noise_val >0.85 and noise_val > 0.2:
					enviroment_layer.set_cell(Vector2i(x,y),source_id, tree_atlas)
					

			
			elif noise_val <= 0.0:
				water_layer.set_cell(Vector2i(x,y),source_id, water_atlas)
	
	ground_layer.set_cells_terrain_connect(sand_tiles_arr, terrain_sand_int, 0)
	ground_layer.set_cells_terrain_connect(grass_tiles_arr, terrain_grass_int, 0)
	cliffs_layer.set_cells_terrain_connect(cliff_tiles_arr, terrain_cliff_int, 0)





	#print("Highest: ", noise_val_arr.max())
	#print("lowest: ", noise_val_arr.min())


func _process(_delta: float) -> void:
	pass
