extends Node
class_name Inventory

@onready var slots = get_tree().get_nodes_in_group("slot")
@onready var player = get_tree().get_first_node_in_group("player")

const CRAFT_COMPLETE = preload("res://sounds/craft_complete.wav")

func _ready() -> void:
	load_inventory()

var items : Array[ItemResource] = []

func get_items():
	return items

func save_inventory():
	var inv_save := InventorySave.new()
	inv_save.items = items
	var result := ResourceSaver.save(inv_save, "user://inventory_data.res")

func load_inventory():
	if ResourceLoader.exists("user://inventory_data.res"):
		var inv_save := load("user://inventory_data.res") as InventorySave
		for item in inv_save.items:
			add_item(item) 

func add_item(item: ItemResource) -> bool :
	
	
	GlobalSFX.play(CRAFT_COMPLETE)
	
	
	for slot in slots:
		if slot.item == null:
			slot.set_item(item)
			items.append(item)
			
			if item.has_method("armor_item"):
				player.armor_bar.armor += item.armor
				
				
			if item.has_method("weapon"):
				match item.type:
					"SWORD":
						player.attack_damage_enemy += item.damage
					"AXE":
						player.attack_damage_tree += item.damage
					"PICKAXE":
						player.attack_damage_rock += item.damage
					
			return true
	return false
	
func remove_item(item: ItemResource) -> bool:
		
	for slot in slots:
		if slot.item == item:
			items.erase(item)
			slot.clear_item()
			
			if item.has_method("armor_item"):
				player.armor_bar.armor -= item.armor
				
			if item.has_method("weapon"):
				match item.type:
					"SWORD":
						player.attack_damage_enemy -= item.damage
					"AXE":
						player.attack_damage_tree -= item.damage
					"PICKAXE":
						player.attack_damage_rock -= item.damage
					
				
			return true
	return false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_inventory"): 
		var crafting_manager = get_tree().get_first_node_in_group("crafting")
		if crafting_manager:
			crafting_manager.check_all_craftable(items)
			
