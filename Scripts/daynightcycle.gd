extends CanvasModulate

@onready var sky_gradient: GradientTexture1D = preload("res://Assets/shit/daynightcycle-gradient-texture.tres")
@onready var time_label: Label = $CanvasLayer/MarginContainer/time_label

var total_ingame_minutes : int

func _ready() -> void:
	add_to_group('time')
	

func get_time() -> String:
	var time : String = "Day %d, %02d:%02d" % [current_day, current_hour, current_minute]
	return time

func get_min() -> int:
	var min : int = total_ingame_minutes
	return min

signal time_tick(day: int, hour: int, minute: int)

var internal_time: float = 20.0
var last_checked_minute: int = -1

var current_day: int = 0
var current_hour: int = 0
var current_minute: int = 0

const DAY_MINUTES = 1440
const HOUR_MINUTES = 60
const TIME_SCALE = TAU / DAY_MINUTES  

func _process(delta: float) -> void:
	var normalized_time = (sin(internal_time - PI / 2.0) + 1.0) * 0.5
	self.color = sky_gradient.gradient.sample(normalized_time)
	_update_clock()

func _update_clock() -> void:
	total_ingame_minutes = int(internal_time / TIME_SCALE)
	
	current_day = total_ingame_minutes / DAY_MINUTES
	var minutes_today = total_ingame_minutes % DAY_MINUTES
	
	current_hour = minutes_today / HOUR_MINUTES
	current_minute = minutes_today % HOUR_MINUTES

	if last_checked_minute != current_minute:
		last_checked_minute = current_minute
		time_tick.emit(current_day, current_hour, current_minute)
		time_label.text = "Day %d, %02d:%02d" % [current_day, current_hour, current_minute]
