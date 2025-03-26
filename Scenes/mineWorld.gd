extends Node2D

@export var noise_height_text : NoiseTexture2D

@onready var player: Node2D = $Player


var noise : Noise

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
	noise = noise_height_text.noise
	noise.seed = randi()
	generateMine()
	spawnPlayer(player_cords)

func spawnPlayer(position : Vector2) -> void:

	player.global_position = position
	
func generateMine() -> void:
	
	for x : int in range(width):
		for y : int in range(height):
			
			var noise_val : float = noise.get_noise_2d(x,y)
			
			noise_val_arr.append(noise_val)
			
			var normalized = remap(noise_val, -1.0, 1.0, 0.0, 1.0)
			
			if normalized > 0.2:
				down_tiles_arr.append(Vector2i(x,y))
				
			void_tiles_arr.append(Vector2i(x,y))
				
		



	down_mine.set_cells_terrain_connect(down_tiles_arr, 0, 1)
	void_mine.set_cells_terrain_connect(void_tiles_arr, 0, 2)

	
	print("Highest: ", noise_val_arr.max())
	print("lowest: ", noise_val_arr.min())
