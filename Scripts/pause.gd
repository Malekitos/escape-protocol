extends Control


func _ready() -> void:
	add_to_group('pause')
	


func _on_exit_pressed() -> void:
	$CanvasLayer/AnimationPlayer.toggle()
	#await $CanvasLayer/AnimationPlayer.animation_finished
	SceneManager.exit_game()
