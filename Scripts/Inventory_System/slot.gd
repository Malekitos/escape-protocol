extends PanelContainer
class_name InventorySlot

var item: ItemResource = null

@onready var icon = $ICON

func _ready() -> void:
	add_to_group("slot")

func set_item(new_item: ItemResource):
	item = new_item
	if item:
		icon.texture = item.item_icon
	else:
		icon.texture = null

func clear_item():
	set_item(null)

func _get_drag_data(at_position: Vector2) -> Variant:
	if item == null:
		return null

	var preview_texture = TextureRect.new()
	preview_texture.texture = item.item_icon
	preview_texture.expand_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview_texture.size = Vector2(20, 20)

	var preview = Control.new()
	preview.add_child(preview_texture)
	preview.z_index = 100
	set_drag_preview(preview)

	return {
		"slot": self,
		"item": item
	}

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has("item") and data["item"] is ItemResource

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if typeof(data) != TYPE_DICTIONARY or not data.has("item") or not data.has("slot"):
		return

	var source_slot = data["slot"]
	var dragged_item = data["item"]

	if source_slot == self:
		return  

	var temp_item = item
	set_item(dragged_item)
	source_slot.set_item(temp_item)
