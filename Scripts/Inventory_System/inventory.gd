extends Node
class_name Inventory

var slots: Array[Node] = []

func _ready() -> void:
	add_to_group("inventory")

func add_item(item: ItemResource) -> bool :
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

#func save_inventory():
	#var inventory_storage : Array
	#for slot in slots:
		#if slot.item:
			#inventory_storage.append(slot.item)
	#return inventory_storage
			
			
func load_inventory(inventory_storage : Array):
	for i in inventory_storage:
		add_item(i)
			
