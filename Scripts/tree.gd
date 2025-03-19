extends Node2D

@export var stats: tree_stats

@onready var sprite = $Sprite2D

func _ready():
	sprite.texture = stats.texture
