extends HBoxContainer

@onready var icon_result: TextureRect = $HBoxContainer/item_icon
@onready var label_name: Label = $HBoxContainer/Label
@onready var input_container: HBoxContainer = $HBoxContainer/MarginContainer/HBoxContainer

func setup(recipe: ItemCraft):
	icon_result.texture = recipe.output_item.item_icon
	label_name.text = recipe.output_item.item_name

	for child in input_container.get_children():
		child.queue_free()


	for input_item in recipe.input_items:
		var icon = TextureRect.new()
		icon.texture = input_item.item_icon
		icon.custom_min_size = Vector2(24, 24)
		input_container.add_child(icon)

func _ready() -> void:
	add_to_group("crafting_item")
