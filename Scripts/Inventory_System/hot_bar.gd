extends HBoxContainer

@onready var item_drop_scene = preload("res://Scenes/Menu_Scenes/item_drop.tscn")
@onready var slots = $".".get_children()
var active_index: int = 0

func _ready():
	highlight_active_slot()

func _unhighlight_all_slots():
	for slot in slots:
		slot.modulate = Color(1, 1, 1, 1)  

func highlight_active_slot():
	_unhighlight_all_slots()
	var active_slot = slots[active_index]
	active_slot.modulate = Color(0.8, 0.8, 0.8, 1)
	#if active_slot.item:
		#print("Активный предмет: ", active_slot.item.item_name)
	##else:
		###print("Активный слот пуст")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			active_index = (active_index - 1 + slots.size()) % slots.size()
			highlight_active_slot()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			active_index = (active_index + 1) % slots.size()
			highlight_active_slot()
			
	if event.is_action_pressed("drop_item"):
		drop_active_item()


func drop_active_item():
	var player = get_tree().get_first_node_in_group("player")
	var inventory = player.get_node('UI/CanvasLayer/AnimationPlayer/Inventory')
	var active_slot = slots[active_index]
	if active_slot.item:
	
		
		var dropped_item = item_drop_scene.instantiate()
		dropped_item.item = active_slot.item
		dropped_item.global_position = player.global_position
		get_tree().current_scene.add_child(dropped_item)
	
		inventory.remove_item(active_slot.item)
		active_slot.clear_item()
		
