extends "res://Scripts/ActionButton.gd"

func _on_pressed():
	if BattleUnits.Player.ap > 0:
		if (BattleUnits.Player.mp >= 8):
			BattleUnits.Player.hp += 5
			BattleUnits.Player.mp -= 5
			BattleUnits.Player.ap -= 1
