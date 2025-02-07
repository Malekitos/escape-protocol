extends CharacterBody2D

@export var speed = 400
@onready var _animated_sprite = $AnimatedSprite2D
@onready var direction = null

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
		
	
