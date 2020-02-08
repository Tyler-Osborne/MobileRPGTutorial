extends "res://Scripts/ActionButton.gd"

const Slash = preload("res://Scenes/Slash.tscn")

func _on_pressed():
	if BattleUnits.Enemy != null \
	and BattleUnits.Player != null \
	and BattleUnits.Player.ap > 0:
		create_slash(BattleUnits.Enemy.global_position)
		BattleUnits.Enemy.take_damage(4)
		BattleUnits.Player.mp += 2
		BattleUnits.Player.ap -= 1

func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
