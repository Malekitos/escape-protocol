extends ProgressBar

var armor = 0 : set = _set_armor
@onready var player: CharacterBody2D = $"../.."

func _set_armor(new_armor):
	armor = min(max_value, new_armor)
	value = new_armor
	player.armor = value

func init_armor(_armor):
	armor = _armor
	max_value = 100
	value = armor
