extends Node

export var CHARACTER_NAME: String 
export var MAX_HP: int
export var MAX_MP: int
export var AMROR: int

onready var enemy = self.get_parent()

onready var MP = MAX_MP
onready var HP = MAX_HP setget set_health

signal no_health
signal health_changed

func _ready():
# warning-ignore:return_value_discarded
	connect("health_changed", enemy, "healthChanged")
# warning-ignore:return_value_discarded
	connect("no_health", enemy, "noHealth")

func set_health(value):
	HP += value
	emit_signal("health_changed",HP)
	if HP <=0:
		emit_signal("no_health")
