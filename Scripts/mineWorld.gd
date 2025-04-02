extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var ore_noise_height_text : NoiseTexture2D

var player_scene = preload("res://Scenes/player.tscn")
var player = player_scene.instantiate()

#@onready var player: Node2D = $Player


var noise : Noise
var ore_noise : Noise

var noise_val_arr : Array[float] = []

var void_tiles_arr : Array[Vector2i] = []
var down_tiles_arr : Array[Vector2i] = []
var up_tiles_arr : Array[Vector2i] = []

@onready var void_mine: TileMapLayer = $voidMine
@onready var down_mine: TileMapLayer = $downMine
@onready var up_mine: TileMapLayer = $upMine

var width : int = 50
var height : int = 50

var player_spawned : bool = false
var player_cords : Vector2


func _ready() -> void:
	
	
	add_child(player)
	
	
	noise = noise_height_text.noise
	noise.seed = randi()
	
	ore_noise = ore_noise_height_text.noise
	ore_noise.seed = randi()
	
	generateMine()
	

func spawnPlayer(position : Vector2) -> void:
	
	player.global_position = position
	
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
					if !player_spawned and normalized > 0.4 :
						spawnPlayer(Vector2i(x,y))
						player_spawned = true
					
						
			void_tiles_arr.append(Vector2i(x,y))
			

	down_mine.set_cells_terrain_connect(down_tiles_arr, 0, 1)
	void_mine.set_cells_terrain_connect(void_tiles_arr, 0, 2)


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
	
	player.z_index = 2
	
	
	stone.global_position = position
	add_child(stone)
