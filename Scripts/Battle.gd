extends Node

const BattleUnits = preload("res://BattleUnits.tres")
onready var battleActionButtons = $UI/BattleActionButtons

func _ready():
	start_player_turn()

func start_enemy_turn():
	battleActionButtons.hide()
	
	if (BattleUnits.Enemy != null):
		BattleUnits.Enemy.attack()
		yield(BattleUnits.Enemy, "end_turn")
	
	start_player_turn()

func start_player_turn():
	battleActionButtons.show()
	
	BattleUnits.Player.ap = BattleUnits.Player.max_ap
	
	yield(BattleUnits.Player, "end_turn")
	start_enemy_turn()

func _on_NextRoomButton_pressed():
	pass

