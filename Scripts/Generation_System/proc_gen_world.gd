extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var noise_tree_text : NoiseTexture2D
@onready var player: Node2D = $Player


var noise : Noise
var tree_noise : Noise

var noise_val_arr = []

var is_loaded_from_save : bool = false

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

var small_stone_arr = [Vector2i(0,4),Vector2i(1,4)]
var small_winter_stone_arr = [Vector2i(0,6),Vector2i(1,6)]

var enemy_spawnpoints : Array[Vector2i]

@onready var fall_layer: TileMapLayer = $fall_layer
@onready var summer_layer: TileMapLayer = $summer_layer
@onready var spring_layer: TileMapLayer = $spring_layer
@onready var winter_layer: TileMapLayer = $winter_layer

@onready var ground_layer: TileMapLayer = $ground_layer


var tree_scene = preload("res://Resources/tree/tree.tscn")
var stone_scene = preload("res://Resources/Rocks/rock.tscn")

var tree_types = {
	"winter" = preload("res://Resources/tree/winter_tree.tres"),
	"summer" = preload("res://Resources/tree/summer_tree.tres"),
	"spring" = preload("res://Resources/tree/spring_tree.tres"),
	"fall" = preload("res://Resources/tree/fall_tree.tres")
}

var rock_types = {
	"stone" = preload("res://Resources/Rocks/stone.tres"),
	"winter_stone" = preload("res://Resources/Rocks/winter_stone.tres")
}

var mineEnter = preload("res://Scenes/entry_mine.tscn")

var width = 120
var height = 120

var Tile_Size = 16 

func _ready() -> void:
	
	add_to_group("proc_gen_world")
	
	var player = get_tree().get_first_node_in_group("player")
	player.global_position = Vector2(50*16 , 50*16)
	
	noise = noise_height_text.noise
	tree_noise = noise_tree_text.noise
	noise.seed = randi()
	tree_noise.seed = randi()
	#noise.seed = 100
	if not is_loaded_from_save:
		generate_world()


func generate_world():

	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			var tree_noise_val = tree_noise.get_noise_2d(x,y)
			
			if x > 10 and y > 10:
				enemy_spawnpoints.append(Vector2i(x * 16,y * 16))
			
			var normalized = remap(noise_val, -1.0, 1.0, 0.0, 1.0)
		
			if normalized >= 0 and normalized <= 0.45:
				fall_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.90:
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "fall")
				if tree_noise_val > 0.79 and tree_noise_val < 0.81:
					ground_layer.set_cell(Vector2i(x,y), 0, fall_bush_arr.pick_random())
				if tree_noise_val > 0.81 and tree_noise_val < 0.84:
					ground_layer.set_cell(Vector2i(x,y), 0, fall_grass_arr.pick_random())
				if tree_noise_val > 0.84 and tree_noise_val < 0.87:
					ground_layer.set_cell(Vector2i(x,y), 0, fall_flowers_arr.pick_random())
				if tree_noise_val > 0.87 and tree_noise_val < 0.89:
					ground_layer.set_cell(Vector2i(x,y), 0, small_stone_arr.pick_random())
					
				if tree_noise_val > 0.895 and tree_noise_val < 0.90:
					spawn_stone(Vector2i(x * Tile_Size ,y * Tile_Size), "stone")
				if tree_noise_val > 0.503 and tree_noise_val < 0.505:
					spawn_mine(Vector2i(x * Tile_Size ,y * Tile_Size))
				
			if normalized >= 0.40 and normalized <= 0.55:
				summer_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9 :
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "summer")
				if tree_noise_val > 0.79 and tree_noise_val < 0.81:
					ground_layer.set_cell(Vector2i(x,y), 0, summer_bush_arr.pick_random())
				if tree_noise_val > 0.81 and tree_noise_val < 0.84:
					ground_layer.set_cell(Vector2i(x,y), 0, summer_grass_arr.pick_random())
				if tree_noise_val > 0.84 and tree_noise_val < 0.87:
					ground_layer.set_cell(Vector2i(x,y), 0, summer_flowers_arr.pick_random())
				if tree_noise_val > 0.87 and tree_noise_val < 0.89:
					ground_layer.set_cell(Vector2i(x,y), 0, small_stone_arr.pick_random())
				if tree_noise_val > 0.895 and tree_noise_val < 0.90:
					spawn_stone(Vector2i(x * Tile_Size ,y * Tile_Size), "stone")
				if tree_noise_val > 0.503 and tree_noise_val < 0.505:
					spawn_mine(Vector2i(x * Tile_Size ,y * Tile_Size))
					
			if normalized >= 0.50 and normalized <= 0.70:
				spring_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.9 :
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "spring")
				if tree_noise_val > 0.79 and tree_noise_val < 0.81:
					ground_layer.set_cell(Vector2i(x,y), 0, spring_bush_arr.pick_random())
				if tree_noise_val > 0.81 and tree_noise_val < 0.84:
					ground_layer.set_cell(Vector2i(x,y), 0, spring_grass_arr.pick_random())
				if tree_noise_val > 0.84 and tree_noise_val < 0.87:
					ground_layer.set_cell(Vector2i(x,y), 0, spring_flowers_arr.pick_random())
				if tree_noise_val > 0.87 and tree_noise_val < 0.89:
					ground_layer.set_cell(Vector2i(x,y), 0, small_stone_arr.pick_random())
				if tree_noise_val > 0.895 and tree_noise_val < 0.90:
					spawn_stone(Vector2i(x * Tile_Size ,y * Tile_Size), "stone")
				if tree_noise_val > 0.503 and tree_noise_val < 0.505:
					spawn_mine(Vector2i(x * Tile_Size ,y * Tile_Size))
					
				
			if normalized >= 0.65:
				winter_tiles_arr.append(Vector2i(x,y))
				if	tree_noise_val > 0.92:
					spawn_tree(Vector2i(x * Tile_Size ,y * Tile_Size), "winter")
				if tree_noise_val > 0.79 and tree_noise_val < 0.81:
					ground_layer.set_cell(Vector2i(x,y), 0, winter_bush_arr.pick_random())
				if tree_noise_val > 0.87 and tree_noise_val < 0.89:
					ground_layer.set_cell(Vector2i(x,y), 0, small_winter_stone_arr.pick_random())
				if tree_noise_val > 0.89 and tree_noise_val < 0.90:
					spawn_stone(Vector2i(x * Tile_Size ,y * Tile_Size), "winter_stone")
				if tree_noise_val > 0.503 and tree_noise_val < 0.505:
					spawn_mine(Vector2i(x * Tile_Size ,y * Tile_Size))
					

	fall_layer.set_cells_terrain_connect(fall_tiles_arr, 0, 0)
	summer_layer.set_cells_terrain_connect(summer_tiles_arr, 0, 1)
	spring_layer.set_cells_terrain_connect(spring_tiles_arr, 0, 2)
	winter_layer.set_cells_terrain_connect(winter_tiles_arr, 0, 3)

	#print("Highest: ", noise_val_arr.max())
	#print("lowest: ", noise_val_arr.min())




func spawn_tree(position: Vector2i, biome: String):
	var tree = tree_scene.instantiate()
	tree.stats = tree_types[biome] # это твой tree_stats.traes
	tree.global_position = position
	add_child(tree)
	tree.owner = self


func spawn_stone(position: Vector2i, type):
	
	var stone = stone_scene.instantiate()
	stone.stats = rock_types[type]
	
	stone.global_position = position
	add_child(stone)
	stone.owner = self
	
func spawn_mine(position: Vector2i):
	pass
	var Mineenter = mineEnter.instantiate()
	Mineenter.global_position = position
	add_child(Mineenter)
	Mineenter.owner = self

	
