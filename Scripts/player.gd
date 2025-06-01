extends CharacterBody2D

@export var speed = 150
@onready var _animated_sprite = $AnimatedSprite2D
@onready var camera_2d = $Camera2D
@onready var direction = "down"

@onready var healthbar: ProgressBar = $CanvasLayer/Healthbar
@onready var armor_bar: ProgressBar = $CanvasLayer/ArmorBar

@onready var damage_sound: AudioStreamPlayer = $DamageSound
const DEATH = preload("res://sounds/death.wav")

var is_hurt : bool = false

@onready var health : int = 30 : set = _change_health
var armor : float = 0 : set = _change_armor
var armor_effect : float

var attack_damage_enemy : int = 5
var attack_damage_tree : int = 1
var attack_damage_rock : int = 1

@onready var ui_scene = preload("res://Scenes/UI.tscn")
@onready var pause_scene = preload("res://Scenes/Menu_Scenes/Pause.tscn")
#@onready var result_scene = preload("res://Scenes/Menu_Scenes/result.tscn")


var in_mine : bool = false
var player_position : Vector2i

var is_loaded_from_save : bool

func _change_health(new_health):
	health = new_health
	healthbar.health = health

func _change_armor(new_armor):
	armor = armor_bar.armor
	armor_effect = 1 - (armor/100 * 0.8)

func _ready() -> void:
	add_to_group('player')
	var pause = pause_scene.instantiate()
	add_child(pause)
	#var result = result_scene.instantiate()
	#add_child(result)
	healthbar.init_health(health)
	armor_bar.init_armor(armor)
	
	if not is_loaded_from_save:
		var ui = ui_scene.instantiate()
		add_child(ui)
		ui.owner = self
	
	GlobalSFX.apply_volume(damage_sound)
	

func take_damage(damage : int):
	
	damage_sound.play()
	
	if is_hurt: return
	is_hurt = true
	
	match direction:
		"down":
			_animated_sprite.play("hurt_front")
		"back":
			_animated_sprite.play("hurt_back")
		"left":
			_animated_sprite.play("hurt_right")
			_animated_sprite.flip_h = true
		"right":
			_animated_sprite.play("hurt_right")
			_animated_sprite.flip_h = false
	
	health -= damage * armor_effect
	await _animated_sprite.animation_finished  
	is_hurt = false
	
	if health <= 0:
		
		GlobalSFX.play(DEATH)

		
		var time_node = get_tree().get_first_node_in_group("time")
		var time = time_node.get_time()
		var minutes_ingame = time_node.get_min()
		SceneManager.time = time
		SceneManager.minutes_ingame = minutes_ingame
		get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/result.tscn")
	

func teleport_to_mine():
	if !in_mine:
		player_position = (global_position + Vector2(80,0))
		SceneManager.clear_level(true)
		SceneManager.set_level(preload("res://Scenes/mine.tscn"), false)
		in_mine = true
	else:
		global_position = player_position
		SceneManager.clear_level(false)
		SceneManager.set_level(preload("res://Scenes/proc_gen_world.tscn"), true)
		in_mine = false
	


func get_input():
	var input_direction = Input.get_vector("left","right","up","down")
	velocity = input_direction * speed
	

	
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

func _process(_delta: float) -> void:
	if is_hurt:
		return
	
	if Input.is_action_pressed("down"):
		_animated_sprite.play("walk")
		direction = "down"
	elif Input.is_action_pressed("up"):
		_animated_sprite.play("walk_back")
		direction = "back"
	elif Input.is_action_pressed("left"):
		_animated_sprite.play("walk_right")
		_animated_sprite.flip_h = true
		direction = "left"
	elif Input.is_action_pressed("right"):
		_animated_sprite.play("walk_right")
		_animated_sprite.flip_h = false
		direction = "right"
	
	

	if velocity.length() == 0:
		match direction:
			"down":
				_animated_sprite.play("idle")
			"back":
				_animated_sprite.play("idle_back")
			"left":
				_animated_sprite.play("idle_right")
				_animated_sprite.flip_h = true
			"right":
				_animated_sprite.play("idle_right")
				_animated_sprite.flip_h = false
		
	
#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("zoom_in"):
		#var zoom_val = camera_2d.zoom.x - 0.05
		#camera_2d.zoom = Vector2(zoom_val, zoom_val)
	#elif Input.is_action_just_pressed("zoom_out"):
		#var zoom_val = camera_2d.zoom.x + 0.05
		#camera_2d.zoom = Vector2(zoom_val, zoom_val)
			
			
