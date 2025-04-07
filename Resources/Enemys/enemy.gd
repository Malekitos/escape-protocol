extends Node2D

@export var stats : enemy_stats
@onready var enemy: Node2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D



var enemy_name : String
var health : int
var speed : int

var player : Node2D 
	
func _ready() -> void:
	animated_sprite_2d.sprite_frames = stats.texture
	enemy.modulate = stats.modulate
	animated_sprite_2d.play("idle")
	enemy.name = stats.name
	enemy.health = stats.health
	enemy.speed = stats.speed
	player = get_tree().get_first_node_in_group('player')
