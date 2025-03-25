extends Node
class_name inventory

@onready var slots:= $GridContainer.get_children()

func add_item(item: ItemResource) -> bool:
	for slot in slots:
		if slot.item == null:
			slot.set_item(item)
			return true
	return false
	
func remove_item(item: ItemResource) -> bool:
	for slot in slots:
		if slot.item == item:
			slot.clear_item()
			return true
	return false
