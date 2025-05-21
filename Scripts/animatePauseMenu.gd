extends AnimationPlayer

@onready var animation_player: AnimationPlayer = $"."
@onready var color_rect: ColorRect = $"../ColorRect"


var is_open = false


func _ready() -> void:
	color_rect.hide()

func toggle():
	if is_open:
		close()
	else:
		open()
		
func open():
	is_open = true
	color_rect.show()
	get_tree().paused = true
	animation_player.play("show_pause")

func close():
	is_open = false
	get_tree().paused = false
	animation_player.play("hide_pause")
	await animation_player.animation_finished
	color_rect.hide()

func _input(event):
	if event.is_action_pressed("pause"):
		toggle()
