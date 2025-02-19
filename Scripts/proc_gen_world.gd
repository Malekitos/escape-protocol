extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var noise_tree_text : NoiseTexture2D


var noise
var tree_noise

#var noise_val_arr = []


#var tree_atlas = Vector2i(15,6)

var fall_tilles_arr = []
var spring_tilles_arr = []
var summer_tilles_arr = []
var winter_tilles_arr = []

var terrain_set_ground = 0

var terrain_id_fall = 0
var terrain_id_spring = 1
var terrain_id_summer = 2
var terrain_id_winter = 3

@onready var fall_layer: TileMapLayer = $fall_layer
@onready var summer_layer: TileMapLayer = $summer_layer
@onready var spring_layer: TileMapLayer = $summer_layer
@onready var winter_layer: TileMapLayer = $summer_layer


@onready var ground_layer: TileMapLayer = $ground_layer
@onready var enviroment_layer: TileMapLayer = $enviroment_layer

@onready var player: Node2D = $Player


var width = 200
var height = 200

func _ready() -> void:
	noise = noise_height_text.noise
	#noise.seed = randi()
	noise.seed = 123
	tree_noise = noise_tree_text.noise
	generate_world()

func generate_world():
	

	
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			var tree_noise_val = tree_noise.get_noise_2d(x,y)

			#noise_val_arr.append(noise_val)
			
			if noise_val <= -0.3:
				fall_tilles_arr.append(Vector2i(x,y))
			if noise_val >= -0.3 && noise_val <= 0:
				summer_tilles_arr.append(Vector2i(x,y))
			if noise_val >= 0 && noise_val <= 0.25:
				spring_tilles_arr.append(Vector2i(x,y))
			#if noise_val >= 0.25:
				#winter_tilles_arr.append(Vector2i(x,y))
				
			
			
			#if noise_val > -0.4:
				#sand_tiles_arr.append(Vector2i(x,y))
				#if noise_val > -0.35:
					#grass_tiles_arr.append(Vector2i(x,y))
					#
					#if noise_val > -0.3:
						#ground_2_layer.set_cell(Vector2i(x,y), source_id, grass_atlas_arr.pick_random())
					#
					#if noise_val > 0.5:
						#cliff_tiles_arr.append(Vector2i(x,y))
#
				#
				#if tree_noise_val >0.85 and noise_val > -0.3:
					#enviroment_layer.set_cell(Vector2i(x,y),source_id, tree_atlas)
					#
	#
	#ground_layer.set_cells_terrain_connect(sand_tiles_arr, terrain_sand_int, 0)
	#ground_layer.set_cells_terrain_connect(grass_tiles_arr, terrain_grass_int, 0)
	#cliffs_layer.set_cells_terrain_connect(cliff_tiles_arr, terrain_cliff_int, 0)

	fall_layer.set_cells_terrain_connect(fall_tilles_arr, 0, 0)
	summer_layer.set_cells_terrain_connect(summer_tilles_arr, 0, 1)
	spring_layer.set_cells_terrain_connect(spring_tilles_arr, 0, 2)
	winter_layer.set_cells_terrain_connect(winter_tilles_arr, 0, 3)









	#print("Highest: ", noise_val_arr.max())
	#print("lowest: ", noise_val_arr.min())


func _process(_delta: float) -> void:
	pass
