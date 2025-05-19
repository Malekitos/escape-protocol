extends HBoxContainer

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var inventory = player.get_node('UI/CanvasLayer/AnimationPlayer/Inventory')


func _ready() -> void:
	add_to_group("crafting_item")

var output_item
var input_item1
var input_item2

func setup(output, input1, input2):
	output_item = output
	input_item1 = input1
	input_item2 = input2

func _on_craft_button_pressed() -> void:
	inventory.remove_item(input_item1)
	inventory.remove_item(input_item2)
	inventory.add_item(output_item)
	var crafting_manager = get_tree().get_first_node_in_group("crafting")
	if crafting_manager:
		crafting_manager.check_all_craftable(inventory.get_items())
