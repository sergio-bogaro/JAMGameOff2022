extends Node

var Spell_1: Object 
var Spell_2: Object
var Spell_3: Object
var Spell_4: Object

var selectedSpell: Object

signal cast_spell

func _ready():
	Spell_1 = load("res://Skills/Spells/EnergyBall.tscn")

func _unhandled_input(event):
	if Input.is_action_just_pressed("cast_spell_1"):
		selectedSpell = Spell_1
		castSpell()
	
	if Input.is_action_just_pressed("cast_spell_2"):
		pass
	
	if Input.is_action_just_pressed("cast_spell_3"):
		pass
	
	if Input.is_action_just_pressed("cast_spell_4"):
		pass

func castSpell():
	emit_signal("cast_spell", selectedSpell)
