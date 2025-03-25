extends PanelContainer
class_name InventorySlot

var item : ItemResource = null

@onready var icon = $ICON

func set_item(new_item: ItemResource):
	item = new_item
	if item:
		icon.texture = item.item_icon
	else:
		icon.texture = null
		
func clear_item():
	set_item(null)
	
