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

func _ready() -> void:
	noise = noise_height_text.noise
	noise.seed = randi()
	#noise.seed = 100
	tree_noise = noise_tree_text.noise
	
	generate_world()

var Tile_Size = 16 

func generate_world():

	print(Tile_Size)

	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			var tree_noise_val = tree_noise.get_noise_2d(x,y)

			#noise_val_arr.append(noise_val)
		
			if noise_val <= -0.15:
				fall_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9:
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "fall")
				
			if noise_val >= -0.35 && noise_val <= 0.0:
				summer_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9 :
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "summer")
				
			if noise_val >= -0.1 && noise_val <= 0.4:
				spring_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9 :
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "spring")
				
			if noise_val >= 0.35:
				winter_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9:
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "winter")
			
				
				
			
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
