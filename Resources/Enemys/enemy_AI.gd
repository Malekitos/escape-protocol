extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var enemy_stats = get_parent().stats
@onready var speed = enemy_stats.speed

@onready var player = get_tree().get_first_node_in_group('player')

	
func _physics_process(delta: float) -> void:
	var dir = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	velocity = dir * speed
	move_and_slide()
	
	if abs(dir.x) > abs(dir.y):
		# Горизонтальное движение
		if dir.x > 0:
			_animated_sprite.play("walk_right")
			_animated_sprite.flip_h = false
		else:
			_animated_sprite.play("walk_right")
			_animated_sprite.flip_h = true
	else:
		# Вертикальное движение
		if dir.y > 0:
			_animated_sprite.play("walk")  # или walk_forward
		else:
			_animated_sprite.play("walk_back")    # или walk_back

func makepath() -> void:
	navigation_agent_2d.target_position = player.global_position


func _on_timer_timeout() -> void:
	makepath()
