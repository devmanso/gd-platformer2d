extends Node2D

onready var ball = $Ball

func _physics_process(delta):
	position = ball.position
