extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

export (int) onready var hp = 25 setget set_hp
export (int) onready var damage = 3

onready var hpLabel = $HPLabel
onready var animationPlayer = $AnimationPlayer

signal died
signal end_turn

func set_hp(new_hp):
	hp = new_hp
	if (hpLabel != null):
		hpLabel.text = str(hp) + "HP"

func attack() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	animationPlayer.play("Attack")
	yield(animationPlayer, "animation_finished")
	emit_signal("end_turn")

func deal_damage():
	BattleUnits.Player.hp -= damage

func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		animationPlayer.play("Shake")

func is_dead():
	return hp <= 0

func _ready():
	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null
