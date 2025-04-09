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
@onready var exit: Node2D = $Exit


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
			

	down_mine.set_cells_terrain_connect(down_tiles_arr, 0, 1)
	void_mine.set_cells_terrain_connect(void_tiles_arr, 0, 2)
	
	for i in range(10):
		spawn_exit()

	for tile in down_tiles_arr:	
		var current_tail = down_mine.get_cell_tile_data(tile)
		if current_tail:
			var tile_data = current_tail.get_custom_data('spawnable')
			if tile_data:
				player.global_position = down_mine.map_to_local(tile)
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

	stone.global_position = position
	add_child(stone)
	
func spawn_exit():
	var exit_x : int = randf_range(0, width - 1)
	var exit_y : int = randf_range(0, height - 1)
	var exit_cords : Vector2i = Vector2i(exit_x, exit_y)
	
	var current_tail = down_mine.get_cell_tile_data(Vector2i(exit_x, exit_y))
	if current_tail:
		var tile_data = current_tail.get_custom_data('spawnable')
		if tile_data:
			
			var world_pos = down_mine.map_to_local(exit_cords)
			
			var enemy_scene = preload("res://Resources/Enemys/enemy.tscn")
			var enemy = enemy_scene.instantiate()
			enemy.stats = preload("res://Resources/Enemys/red_enemy.tres")
			enemy.global_position = world_pos
			add_child(enemy)
			print("spawn")
			
			var ENTRY_MINE = preload("res://Scenes/entry_mine.tscn")
			var exit_mine = ENTRY_MINE.instantiate()
			add_child(exit_mine)
			exit_mine.global_position = world_pos
			exit_mine.z_index = 10
	

	

	
