extends Node2D

onready var blades = $Blades

func _physics_process(delta):
	rotation += 0.01
