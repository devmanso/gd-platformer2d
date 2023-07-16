extends StaticBody2D

export var damage = 100
onready var sprite = $Sprite

func _ready():
	sprite.hide()

func _on_KillArea_body_entered(body):
	if "Player" in body.name:
		body.die()
	if "Ball" in body.name:
		body.queue_free()

func _on_KillArea_body_exited(body):
	pass
