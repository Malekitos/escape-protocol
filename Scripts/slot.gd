extends PanelContainer
class_name InventorySlot

@onready var icon = $ICON

func set_item(new_item: ItemResource):
	icon.texture = new_item.item_icon
	
