extends KinematicBody2D

export var MAX_SPEED: int
export var ACCELERATION: int
export var FRICTION: int

var speed = Vector2.ZERO

onready var basicAttack = preload("res://Skills/BasicAttacks/FireArrow.tscn")
onready var playerAnimation = $AnimatedSprite
onready var timer = $FireRate
onready var staff = $Staff

var canCast: bool = true
var isCharging: bool = false

func _ready():
	var _connector = SkillManager.connect("cast_spell", self, "castSpeel")

func _physics_process(delta):
	if Input.is_action_pressed("charge"):
		playerAnimation.animation = "Charge"
		isCharging = true
	
	else:
		isCharging = false
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	followMouse()
	
	if Input.is_action_pressed("shoot"):
		if canCast:
			castSpeel(basicAttack)
			timer.start()
			canCast = false
	
	if input_vector != Vector2.ZERO:
		playerAnimation.animation = "Run"
		speed = speed.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		playerAnimation.flip_h = speed.x < 0
	else:
		if !isCharging:
			playerAnimation.animation = "Idle"
		
		speed = speed.move_toward(Vector2.ZERO, FRICTION * delta)
	
	speed = move_and_slide(speed)

func followMouse():
	var rotationDegree = staff.global_position.direction_to(get_global_mouse_position()).angle()
	staff.rotation = rotationDegree

func castSpeel(spell):
	var SPELL = spell.instance()
	get_tree().current_scene.add_child(SPELL)
	SPELL.global_position = staff.global_position
	
	var rotation = staff.global_position.direction_to(get_global_mouse_position()).angle()
	SPELL.rotation = rotation

func _on_Timer_timeout():
	canCast = true
