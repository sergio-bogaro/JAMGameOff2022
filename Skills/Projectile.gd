extends Area2D

export var SPEED: int
export var DAMAGE: int

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Projectile_area_entered(area):
	pass # Replace with function body.
