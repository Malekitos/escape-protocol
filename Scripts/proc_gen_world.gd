extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var noise_tree_text : NoiseTexture2D

var noise : Noise
var tree_noise : Noise

var noise_val_arr = []


var fall_tiles_arr = []
var spring_tiles_arr = []
var summer_tiles_arr = []
var winter_tiles_arr = []

var terrain_set_ground = 0

var terrain_id_fall = 0
var terrain_id_spring = 1
var terrain_id_summer = 2
var terrain_id_winter = 3

var spring_bush_arr = [Vector2i(7,3),Vector2i(7,4)]
var summer_bush_arr = [Vector2i(8,3),Vector2i(8,4)]
var fall_bush_arr = [Vector2i(9,3),Vector2i(9,4)]
var winter_bush_arr = [Vector2i(10,3),Vector2i(10,4)]

var spring_grass_arr = [Vector2i(7,5),Vector2i(7,6),Vector2i(7,7),Vector2i(8,5),Vector2i(8,6),Vector2i(8,7)]
var summer_grass_arr = [Vector2i(9,5),Vector2i(9,6),Vector2i(9,7),Vector2i(10,5),Vector2i(10,6),Vector2i(10,7)]
var fall_grass_arr = [Vector2i(11,5),Vector2i(11,6),Vector2i(11,7),Vector2i(12,5),Vector2i(12,6),Vector2i(12,7)]

var spring_flowers_arr = [Vector2i(7,8),Vector2i(7,9),Vector2i(7,10),Vector2i(7,11),
							Vector2i(8,8),Vector2i(8,9),Vector2i(8,10),Vector2i(8,11)]
var summer_flowers_arr = [Vector2i(9,8),Vector2i(9,9),Vector2i(9,10),Vector2i(9,11),
							Vector2i(10,8),Vector2i(10,9),Vector2i(10,10),Vector2i(10,11)]
var fall_flowers_arr = [Vector2i(11,8),Vector2i(11,9),Vector2i(11,10),Vector2i(11,11),
							Vector2i(12,8),Vector2i(12,9),Vector2i(12,10),Vector2i(12,11)]


@onready var fall_layer: TileMapLayer = $fall_layer
@onready var summer_layer: TileMapLayer = $summer_layer
@onready var spring_layer: TileMapLayer = $spring_layer
@onready var winter_layer: TileMapLayer = $winter_layer


@onready var ground_layer: TileMapLayer = $ground_layer
@onready var enviroment_layer: TileMapLayer = $enviroment_layer


var tree_fall = preload("res://Scenes/tree_fall.tscn")
var tree_winter = preload("res://Scenes/tree_winter.tscn")
var tree_spring = preload("res://Scenes/tree_spring.tscn")
var tree_summer = preload("res://Scenes/tree_summer.tscn")


var width = 200
var height = 200

var Tile_Size = 16 

func _ready() -> void:
	noise = noise_height_text.noise
	noise.seed = randi()
	#noise.seed = 100
	tree_noise = noise_tree_text.noise
	
	generate_world()



func generate_world():

	print(Tile_Size)

	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			var tree_noise_val = tree_noise.get_noise_2d(x,y)

			#noise_val_arr.append(noise_val)
		
			if noise_val <= -0.10:
				fall_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9:
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "fall")
				if tree_noise_val > 0.79 and tree_noise_val < 0.81:
					ground_layer.set_cell(Vector2i(x,y), 0, fall_bush_arr.pick_random())
				if tree_noise_val > 0.81 and tree_noise_val < 0.84:
					ground_layer.set_cell(Vector2i(x,y), 0, fall_grass_arr.pick_random())
				if tree_noise_val > 0.84 and tree_noise_val < 0.87:
					ground_layer.set_cell(Vector2i(x,y), 0, fall_flowers_arr.pick_random())
				
			if noise_val >= -0.30 && noise_val <= 0.0:
				summer_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9 :
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "summer")
				if tree_noise_val > 0.79 and tree_noise_val < 0.81:
					ground_layer.set_cell(Vector2i(x,y), 0, summer_bush_arr.pick_random())
				if tree_noise_val > 0.81 and tree_noise_val < 0.84:
					ground_layer.set_cell(Vector2i(x,y), 0, summer_grass_arr.pick_random())
				if tree_noise_val > 0.84 and tree_noise_val < 0.87:
					ground_layer.set_cell(Vector2i(x,y), 0, summer_flowers_arr.pick_random())
				
			if noise_val >= -0.1 && noise_val <= 0.35:
				spring_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9 :
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "spring")
				if tree_noise_val > 0.79 and tree_noise_val < 0.81:
					ground_layer.set_cell(Vector2i(x,y), 0, spring_bush_arr.pick_random())
				if tree_noise_val > 0.81 and tree_noise_val < 0.84:
					ground_layer.set_cell(Vector2i(x,y), 0, spring_grass_arr.pick_random())
				if tree_noise_val > 0.84 and tree_noise_val < 0.87:
					ground_layer.set_cell(Vector2i(x,y), 0, spring_flowers_arr.pick_random())
				
			if noise_val >= 0.30:
				winter_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9:
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "winter")
				if tree_noise_val > 0.79 and tree_noise_val < 0.81:
					ground_layer.set_cell(Vector2i(x,y), 0, winter_bush_arr.pick_random())

			
				
				
			
				#if tree_noise_val >0.85 and noise_val > -0.3:
					#enviroment_layer.set_cell(Vector2i(x,y),source_id, tree_atlas)
					#

	fall_layer.set_cells_terrain_connect(fall_tiles_arr, 0, 0)
	summer_layer.set_cells_terrain_connect(summer_tiles_arr, 0, 1)
	spring_layer.set_cells_terrain_connect(spring_tiles_arr, 0, 2)
	winter_layer.set_cells_terrain_connect(winter_tiles_arr, 0, 3)



	#print("Highest: ", noise_val_arr.max())
	#print("lowest: ", noise_val_arr.min())

func spawn_tree(position: Vector2i, biome):
	
	var tree = null
	
	match biome:
		"fall":
			tree = tree_fall.instantiate()
		"summer":
			tree = tree_summer.instantiate()
		"spring":
			tree = tree_spring.instantiate()
		"winter":
			tree = tree_winter.instantiate()
	


	tree.global_position = position
	add_child(tree)
