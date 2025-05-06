extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D


var item: ItemResource

func _ready():
	if item:
		sprite_2d.texture = item.item_icon




func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if player:
			#player.add_item_to_inventory(item)
			queue_free()
