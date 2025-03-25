extends Node
class_name Attacker

var damage : int

func attack(target: Node):
	if target.has_method("take_damage"):
		target.take_damage(damage)
