extends Node
class_name Inventory

@onready var slots = get_tree().get_nodes_in_group("slot")

var items : Array[ItemResource] = []

func add_item(item: ItemResource) -> bool :
	for slot in slots:
		if slot.item == null:
			slot.set_item(item)
			items.append(item)
			print(items)
			return true
	return false
	
func remove_item(item: ItemResource) -> bool:
	for slot in slots:
		if slot.item == item:
			slot.clear_item()
			items.erase(item)
			print(items)	
			return true
	return false
