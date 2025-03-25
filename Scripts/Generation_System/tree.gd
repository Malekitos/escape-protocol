extends Node2D

@export var stats: tree_stats

@onready var sprite = $Sprite2D

func _ready():
	sprite.texture = stats.texture

	
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var attacked = Attacked.new()
			attacked.attacked(0, $".")
