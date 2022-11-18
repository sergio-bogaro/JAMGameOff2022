extends Node2D

var player = null

func detected():
	return player != null

func _on_PlayerDetection_body_entered(body):
	player = body

func _on_ChaseDistance_body_exited(_body):
	player = null
