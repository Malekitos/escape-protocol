extends Node
class_name Attacked

var health : int
var camera = CameraShake.new()

func attacked(damage: int, person: Node):
	#person.health -= damage
	#if person.health <= 0:
		#person.die()
	person.animation_player.play('hit_flash')

	
