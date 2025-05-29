extends Node2D

@export var stats : enemy_stats
@onready var enemy: Node2D = $"."
@onready var _animated_sprite: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var healthbar: ProgressBar = $CharacterBody2D/Healthbar
@onready var animated_sprite_2d: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D
@onready var attack_timer: Timer = $CharacterBody2D/AttackArea/AttackTimer


var enemy_name : String
var health : int
var speed : int

var target : Node2D
var player : Node2D 
	
func _ready() -> void:
	_animated_sprite.sprite_frames = stats.texture
	animated_sprite_2d.modulate = stats.modulate
	_animated_sprite.play("idle")
	enemy.name = stats.name
	enemy.health = stats.health
	enemy.speed = stats.speed
	player = get_tree().get_first_node_in_group('player')
	healthbar.init_health(health)
	healthbar.hide()
	

func damage(attack: Attack):
	health -= attack.attack_damage
	healthbar.show()
	healthbar.health = health
	var delay_timer = get_tree().create_timer(0.3)
	
	animated_sprite_2d.modulate = Color(100,100,100,100)
	character_body_2d.speed = 0
	
	var dir = character_body_2d.dir
	
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			_animated_sprite.play("hurt_right")
			_animated_sprite.flip_h = false
		else:
			_animated_sprite.play("hurt_right")
			_animated_sprite.flip_h = true
	else:
		if dir.y > 0:
			_animated_sprite.play("hurt") 
		else:
			_animated_sprite.play("hurt")  
	

		
	await delay_timer.timeout
	$CharacterBody2D.speed = stats.speed
	animated_sprite_2d.modulate = stats.modulate
	
	if health < 0:

		#inventory.add_item(preload("res://Resources/items/materials/wood.tres"))
		_animated_sprite.play("death_front")
		
		queue_free()
		return
		



func _on_damages_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var attack = Attack.new()
			attack.attack_damage = player.attack_damage
			damage(attack)


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		target = body
		attack_timer.start()



func _on_attack_timer_timeout() -> void:
	target.take_damage(20)


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.has_method("take_damage"):
		attack_timer.stop()
