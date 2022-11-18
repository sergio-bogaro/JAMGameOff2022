extends Node2D

onready var status = $Status
onready var entityAnimation = $AnimatedSprite
onready var hoverSimbol = $Sprite
onready var enemyPlace = self.get_parent()

var deathEffect = preload("res://Assets/Effects/DeathEffect/DeathEffect.tscn")

func selected():
	hoverSimbol.visible = true

func unSelect():
	hoverSimbol.visible = false

func healthChanged(newHealth):
	var enemyNumber = int(enemyPlace.name)
	enemyPlace.enemyStatus.set_health(enemyNumber,newHealth)

func noHealth():
	enemyPlace.getButton()
	deathEffect = deathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position
	self.visible = false
