extends CharacterBody2D

@export var speed = 150
@onready var _animated_sprite = $AnimatedSprite2D
@onready var camera_2d = $Camera2D
@onready var direction = null

@onready var healthbar: ProgressBar = $CanvasLayer/Healthbar
@onready var armor_bar: ProgressBar = $CanvasLayer/ArmorBar

var health = 100
var armor = 0 : set = _change_armor

@onready var ui_scene = preload("res://Scenes/UI.tscn")
@onready var pause_scene = preload("res://Scenes/Menu_Scenes/Pause.tscn")

var in_mine : bool = false
var player_position : Vector2i

var is_loaded_from_save : bool

func _change_armor(new_armor):
	armor = armor_bar.armor
	print(armor)

func _ready() -> void:
	add_to_group('player')
	var pause = pause_scene.instantiate()
	add_child(pause)
	healthbar.init_health(health)
	armor_bar.init_armor(armor)
	
	if not is_loaded_from_save:
		var ui = ui_scene.instantiate()
		add_child(ui)
		ui.owner = self
	
	
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
	
var attack_damage : int = 5

func get_input():
	var input_direction = Input.get_vector("left","right","up","down")
	velocity = input_direction * speed
	

	
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

func _process(_delta: float) -> void:
	
	
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
		
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("zoom_in"):
		var zoom_val = camera_2d.zoom.x - 0.05
		camera_2d.zoom = Vector2(zoom_val, zoom_val)
	elif Input.is_action_just_pressed("zoom_out"):
		var zoom_val = camera_2d.zoom.x + 0.05
		camera_2d.zoom = Vector2(zoom_val, zoom_val)
			
			
