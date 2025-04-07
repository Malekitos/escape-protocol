extends PanelContainer
class_name InventorySlot

var item : ItemResource = null

@onready var count: Label = $MarginContainer/count
@onready var icon = $ICON



func _ready() -> void:
	add_to_group("slot")
	count.visible = false

func set_item(new_item: ItemResource):
	item = new_item
	if item:
		icon.texture = item.item_icon
	else:
		icon.texture = null
		
func clear_item():
	set_item(null)
	

func _get_drag_data(at_position: Vector2) -> Variant:
	
	var preview_texture = TextureRect.new()

	if item != null:
		preview_texture.texture = item.item_icon
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(20,20)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	preview.z_index = 100
	set_drag_preview(preview)
	
	return item
	
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is ItemResource
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is ItemResource:
		var previous_item = item
		set_item(data)
		
		for slot in get_tree().get_nodes_in_group("slot"):
			if slot != self and slot.item == data:
				slot.set_item(previous_item)
				break
	
