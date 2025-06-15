extends PanelContainer

class_name CraftingManager
	

@onready var recepies_list = get_tree().get_first_node_in_group("recepies_list")
# UI list
@onready var crafting_item = preload("res://Scenes/Inventory_scenes/crafting_item.tscn").instantiate()

@export var craft_items: Array[ItemCraft] = [
	preload("res://Resources/items/Crafts/cooper_craft.tres"),
	preload("res://Resources/items/Crafts/iron_boots_craft.tres"),
	preload("res://Resources/items/Crafts/Iron_craft.tres"),
 	preload("res://Resources/items/Crafts/iron_gloves_craft.tres"),
	preload("res://Resources/items/Crafts/iron_helmet_craft.tres"),
	preload("res://Resources/items/Crafts/iron_suite_craft.tres"),
	preload("res://Resources/items/Crafts/iron_sword_craft.tres"),
	preload("res://Resources/items/Crafts/stone_axe.tres"),
	preload("res://Resources/items/Crafts/stone_pickaxe.tres"),
	preload("res://Resources/items/Crafts/Torch-craft.tres"),
	preload("res://Resources/items/Crafts/wood_boots_craft.tres"),
	preload("res://Resources/items/Crafts/wood_gloves_craft.tres"),
	preload("res://Resources/items/Crafts/wood_helmet_craft.tres"),
	preload("res://Resources/items/Crafts/wood_suite_craft.tres"),
	preload("res://Resources/items/Crafts/wood_sword_craft.tres")
]

func _ready():
	add_to_group("crafting")



func can_craft(recipe: ItemCraft, inventory_items: Array[ItemResource]) -> bool:
	var temp_inventory := inventory_items.duplicate()
	for input_item in recipe.input_items:
		if not temp_inventory.has(input_item):
			return false
		temp_inventory.erase(input_item) 
	return true

func check_all_craftable(inventory_items: Array[ItemResource]) -> void:
	
	for child in recepies_list.get_children():
		child.queue_free()
	
	
	for recipe in craft_items:
		
		if can_craft(recipe, inventory_items):
			var inputs := ", ".join(recipe.input_items.map(func(i): return i.item_name))
			#print("Можно создать:", recipe.output_item.item_name, "из:", inputs)

			var crafting_item = preload("res://Scenes/Inventory_scenes/crafting_item.tscn").instantiate()
			
			crafting_item.setup(recipe.output_item,recipe.input_items[0], recipe.input_items[1] )
			
			var label = crafting_item.get_node("HBoxContainer/Label")
			var item_icon = crafting_item.get_node("HBoxContainer/item_icon")
			var recipies1_icon = crafting_item.get_node("HBoxContainer/MarginContainer/HBoxContainer/resource_icon1")
			var recipies2_icon = crafting_item.get_node("HBoxContainer/MarginContainer/HBoxContainer/resource_icon2")

			label.text = recipe.output_item.item_name
			item_icon.texture = recipe.output_item.item_icon
			recipies1_icon.texture = recipe.input_items[0].item_icon if recipe.input_items.size() > 0 else null
			recipies2_icon.texture = recipe.input_items[1].item_icon if recipe.input_items.size() > 1 else null

			recepies_list.add_child(crafting_item)
