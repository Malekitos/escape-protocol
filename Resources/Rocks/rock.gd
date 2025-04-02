extends Node2D

@export var stats: Rock_stats
@onready var sprite = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#var player = Player.new()
#var inventory =  Inventory.new()
var health = 20
var player
var inventory

func _ready() -> void:
	sprite.texture = stats.texture
	player = get_tree().get_nodes_in_group("player")[0]
	inventory = get_tree().get_nodes_in_group("inventory")[0]

func damage(attack: Attack):

	health -= attack.attack_damage
	animation_player.play("hit_flash")
	if health < 0:
		#add_child(Global.inventory)
		#Global.inventory.add_item(stats.output)
		
		add_child(inventory)
		inventory.add_item(stats.output)
		
		queue_free()
		return


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var attack = Attack.new()
			attack.attack_damage = player.attack_damage
			damage(attack)
			
