extends RigidBody2D

export var tpPosition : Vector2

var teleport

func _integrate_forces(state):
	if teleport:
		global_position = tpPosition
		
	
