extends Node2D

@onready var player: AudioStreamPlayer = $MusicPlayer

const EXPLORATION_CHIPTUNE_RPG_ADVENTURE_THEME_336428 = preload("res://sounds/background_music/exploration-chiptune-rpg-adventure-theme-336428.mp3")
const FAST_PACED_8_BIT_CHIPTUNE_INSTRUMENTAL_MEDIUM_LEVEL_346221 = preload("res://sounds/background_music/fast-paced-8-bit-chiptune-instrumental-medium-level-346221.mp3")
const FRIDAY_THRASH_METAL_INSTRUMENTAL_351526 = preload("res://sounds/background_music/friday-thrash-metal-instrumental-351526.mp3")
const KANSAS_TORNADOES_NEO_WESTERN_HARD_BLUES_INSTRUMENTAL_346696 = preload("res://sounds/background_music/kansas-tornadoes-neo-western-hard-blues-instrumental-346696.mp3")
const METAL_CHIPPER_8_BIT_HEAVY_METAL_FUSION_INSTRUMENTAL_351589 = preload("res://sounds/background_music/metal-chipper-8-bit-heavy-metal-fusion-instrumental-351589.mp3")
const NEO_WESTERN_BLUES_INSTRUMENTAL_KIDNEY_STONES_346302 = preload("res://sounds/background_music/neo-western-blues-instrumental-kidney-stones-346302.mp3")
const NEO_WESTERN_BLUES_ROCK_INSTRUMENTAL_JMJ_346210 = preload("res://sounds/background_music/neo-western-blues-rock-instrumental-jmj-346210.mp3")
const RPG_BATTLE_CHIPTUNE_VIDEO_GAME_MUSIC_346666 = preload("res://sounds/background_music/rpg-battle-chiptune-video-game-music-346666.mp3")
const STRANGER_THINGS_124008 = preload("res://sounds/background_music/stranger-things-124008.mp3")


var music_tracks : Array = [
	EXPLORATION_CHIPTUNE_RPG_ADVENTURE_THEME_336428,
	FAST_PACED_8_BIT_CHIPTUNE_INSTRUMENTAL_MEDIUM_LEVEL_346221,
	FRIDAY_THRASH_METAL_INSTRUMENTAL_351526,EXPLORATION_CHIPTUNE_RPG_ADVENTURE_THEME_336428,
	KANSAS_TORNADOES_NEO_WESTERN_HARD_BLUES_INSTRUMENTAL_346696,
	METAL_CHIPPER_8_BIT_HEAVY_METAL_FUSION_INSTRUMENTAL_351589,
	NEO_WESTERN_BLUES_INSTRUMENTAL_KIDNEY_STONES_346302,
	NEO_WESTERN_BLUES_ROCK_INSTRUMENTAL_JMJ_346210,
	RPG_BATTLE_CHIPTUNE_VIDEO_GAME_MUSIC_346666,
	STRANGER_THINGS_124008
]	


func _ready():
	randomize()
	
	if FileAccess.file_exists("user://volume.txt"):
		var f = FileAccess.open("user://volume.txt", FileAccess.READ)
		set_volume(f.get_float())

	player.finished.connect(_on_music_finished)
	play_random_music()

func play_random_music():
	if music_tracks.is_empty():
		push_warning("Нет треков для воспроизведения")
		return

	var index = randi() % music_tracks.size()
	var selected = music_tracks[index]
	play_music(selected)

func play_music(stream: AudioStream):
	if player.stream != stream:
		player.stream = stream
	player.play()

func stop_music():
	player.stop()

func set_volume(db: float):
	player.volume_db = db  
	save_volume()

func save_volume():
	var f = FileAccess.open("user://volume.txt", FileAccess.WRITE)
	f.store_float(player.volume_db)

func _on_music_finished():
	play_random_music()
