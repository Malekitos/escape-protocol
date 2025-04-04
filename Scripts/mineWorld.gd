extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var ore_noise_height_text : NoiseTexture2D


var noise : Noise
var ore_noise : Noise

var noise_val_arr : Array[float] = []

var void_tiles_arr : Array[Vector2i] = []
var down_tiles_arr : Array[Vector2i] = []
var up_tiles_arr : Array[Vector2i] = []

@onready var void_mine: TileMapLayer = $voidMine
@onready var down_mine: TileMapLayer = $downMine
@onready var up_mine: TileMapLayer = $upMine

const ENTRY_MINE = preload("res://Scenes/entry_mine.tscn")

var width : int = 50
var height : int = 50

var player_spawned : bool = false

@onready var player = get_tree().get_nodes_in_group('player')[0]

func _ready() -> void:
	
	

	noise = noise_height_text.noise
	noise.seed = randi()
	
	ore_noise = ore_noise_height_text.noise
	ore_noise.seed = randi()
	
	generateMine()
	



func generateMine() -> void:
	
	var exit_x : int = randf_range(0,50)
	var exit_y : int = randf_range(0,50)
	var exit_cords : Vector2i = Vector2i(exit_x * 16, exit_y * 16)
	
	var exit = ENTRY_MINE.instantiate()
	add_child(exit)
	exit.global_position = exit_cords
	
	for x : int in range(width):
		for y : int in range(height):
		
			var noise_val : float = noise.get_noise_2d(x,y)
			var ore_noise_val : float = ore_noise.get_noise_2d(x,y)
			
			var normalized = remap(noise_val, -1.0, 1.0, 0.0, 1.0)
			var ore_normalized = remap(ore_noise_val, -1.0, 1.0, 0.0, 1.0)
			
			if normalized > 0.2:
				down_tiles_arr.append(Vector2i(x, y))
				if ore_normalized > 0.8 and normalized > 0.35:
					spawn_stone(Vector2i(x * 16, y * 16))


			void_tiles_arr.append(Vector2i(x,y))
			

	down_mine.set_cells_terrain_connect(down_tiles_arr, 0, 1)
	void_mine.set_cells_terrain_connect(void_tiles_arr, 0, 2)

	for tile in down_tiles_arr:	
		var current_tail = down_mine.get_cell_tile_data(tile)
		if current_tail:
			var tile_data = current_tail.get_custom_data('spawnable')
			if tile_data:
				print(tile)
				player.global_position = down_mine.map_to_local(tile)
				print(player.global_position)
				break
		


var stone_scene = preload("res://Resources/Rocks/rock.tscn")			

var rock_types = [
	preload("res://Resources/Rocks/ore_coal.tres"),
	preload("res://Resources/Rocks/ore_cooper.tres"),
	preload("res://Resources/Rocks/ore_iron.tres")
]
		
func spawn_stone(position: Vector2i):
	
	var stone = stone_scene.instantiate()
	stone.stats = rock_types[randi_range(0,2)]
	
	var colider = stone.get_node('Sprite2D/StaticBody2D/CollisionShape2D')
	colider.disabled = true
	
	#player.z_index = 2
	
	
	stone.global_position = position
	add_child(stone)
