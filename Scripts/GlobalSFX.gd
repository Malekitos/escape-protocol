extends Node

var volume_db: float = 0.0  

func _ready():
	if FileAccess.file_exists("user://volume_sfx.txt"):
		var f = FileAccess.open("user://volume_sfx.txt", FileAccess.READ)
		volume_db = f.get_float()

func set_volume(db: float):
	volume_db = db
	save_volume()

func apply_volume(player: AudioStreamPlayer):
	if player:
		player.volume_db = volume_db

func apply_volume_2d(player: AudioStreamPlayer2D):
	if player:
		player.volume_db = volume_db

func save_volume():
	var f = FileAccess.open("user://volume_sfx.txt", FileAccess.WRITE)
	f.store_float(volume_db)
