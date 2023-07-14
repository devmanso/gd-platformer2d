extends StaticBody2D

export var damage = 100

func _on_KillArea_body_entered(body):
	if "Player" in body.name:
		
		body.die()

func _on_KillArea_body_exited(body):
	pass
