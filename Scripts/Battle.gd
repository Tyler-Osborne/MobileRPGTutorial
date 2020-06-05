extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = []

onready var enemy = BattleUnits.Enemy
onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition

func _ready():
	randomize()
	nextRoomButton.hide()
	start_player_turn()
	if enemy != null:
		enemy.connect("died", self, "_on_Enemy_died")

func start_enemy_turn():
	battleActionButtons.hide()
	
	if (enemy != null and not enemy.is_queued_for_deletion()):
		enemy.attack()
		yield(enemy, "end_turn")
	
	start_player_turn()

func start_player_turn():
	battleActionButtons.show()
	
	BattleUnits.Player.ap = BattleUnits.Player.max_ap
	
	yield(BattleUnits.Player, "end_turn")
	start_enemy_turn()

func create_new_enemy():
	enemies.shuffle()
	enemy = enemies.front()
	enemy = enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died():
	nextRoomButton.show()
	battleActionButtons.hide()

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	create_new_enemy()
	start_player_turn()
	

