extends Node

export var MAX_HP: int
export var MAX_MP: int

var hp: int setget setHP
var mp: int setget setMP

signal mana_changed
signal health_changed

func _ready():
	var _connector
	_connector = connect("health_changed", PlayerUi, "HealthChanged")
	_connector = connect("mana_changed", PlayerUi, "ManaChanged")
	
	setMP(MAX_MP)
	setHP(MAX_HP)

func setMP(value):
	mp += value
	emit_signal("mana_changed", mp)

func setHP(value):
	hp += value
	emit_signal("health_changed", hp)
