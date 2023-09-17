extends Area2D

onready var ball_instance = preload("res://Ball.tscn")

export var teleportPosition : Vector2

var newBall

func _on_Portal_body_entered(body):
	if "Player" in body.name:
		body.position = teleportPosition
	
	if "Ball" in body.name:
		newBall = ball_instance.instance()
		newBall.position = teleportPosition
		get_parent().add_child(newBall)
		body.queue_free()
	
	if "Test" in body.name:
		body.position = teleportPosition


#	if body is RigidBody2D:
#		var rigidbody = body as RigidBody2D
#		var original_collision_layer = rigidbody.collision_layer
#		var original_collision_mask = rigidbody.collision_mask
#
#		# Temporarily disable collisions
#		rigidbody.set_collision_layer(0)
#		rigidbody.set_collision_mask(0)
#
#		# Teleport the rigidbody
#		rigidbody.position = teleportPosition
#
#		# Restore original collision settings
#		rigidbody.set_collision_layer(original_collision_layer)
#		rigidbody.set_collision_mask(original_collision_mask)
