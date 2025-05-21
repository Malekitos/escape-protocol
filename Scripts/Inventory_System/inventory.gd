extends Node
class_name Inventory

@onready var slots = get_tree().get_nodes_in_group("slot")


var items : Array[ItemResource] = []

func get_items():
	return items

func add_item(item: ItemResource) -> bool :
	for slot in slots:
		if slot.item == null:
			slot.set_item(item)
			items.append(item)
			return true
	return false
	
func remove_item(item: ItemResource) -> bool:
		
	for slot in slots:
		if slot.item == item:
			items.erase(item)
			slot.clear_item()
			print("Инвентарь:",items)
			return true
	return false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_inventory"): 
		var crafting_manager = get_tree().get_first_node_in_group("crafting")
		if crafting_manager:
			crafting_manager.check_all_craftable(items)
			
