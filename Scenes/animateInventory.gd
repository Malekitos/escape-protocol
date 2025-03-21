extends AnimationPlayer

@onready var animation_player: AnimationPlayer = $"."
@onready var inventory: Inventory = $Inventory

var is_open = false

func _ready() -> void:
	$Inventory.hide()

func toggle():
	if is_open:
		close()
	else:
		open()
		
func open():
	is_open = true
	$Inventory.show()
	#get_tree().paused = true
	animation_player.play("show_inventory")

func close():
	is_open = false
	#get_tree().paused = false
	animation_player.play("hide_inventory")
	await animation_player.animation_finished
	$Inventory.hide()

func _unhandled_input(event):
	if event.is_action_pressed("ui_inventory"):
		toggle()
