extends KinematicBody2D

enum {
	IDLE,
	WANDER,
	CHASE
}

export var ACCELERATION: int
export var MAX_SPEED: int
export var FRICTION: int
export var BATTLE_MODE_PATH: String

onready var groupInArea = $GroupInArea
onready var sprite = $AnimatedSprite
onready var detectionZone = $PlayerDetection
onready var softColision = $SoftColision

var DeathEffect = preload("res://Assets/Effects/DeathEffect/DeathEffect.tscn")
var speed = Vector2.ZERO
var state = IDLE


func _physics_process(delta):
	
	match state:
		IDLE:
			speed = speed.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			seek_player()
		CHASE:
			var player = detectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				speed = speed.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				sprite.animation = "Idle"
				state = IDLE
			sprite.flip_h = speed.x < 0
	
	if softColision.is_coliding():
		speed += softColision.get_push_vector() * delta * 400
	speed = move_and_slide(speed)

func seek_player():
	if detectionZone.detected():
		sprite.animation = "Run"
		state = CHASE


func _on_Stats_no_health():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position
	queue_free()

func _on_GroupInArea_body_entered(body):
	var enemies = body.BATTLE_MODE_PATH
	BattleHandler.GetEnemies(enemies)

func StartBattle():
	groupInArea.monitoring = true
	yield(get_tree().create_timer(0.5), "timeout")
	BattleHandler.StartBatle()
	BattleHandler.IntanceEnemies()
	BattleHandler.IntanceAllies()
