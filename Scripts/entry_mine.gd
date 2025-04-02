extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method('teleport_to_mine'):
		body.teleport_to_mine()
