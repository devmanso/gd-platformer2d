extends StaticBody2D

export var damage = 100
export var isVisible = true
onready var sprite = $Sprite

func _ready():
	if !isVisible:
		sprite.hide()

func _on_KillArea_body_entered(body):
	if "Player" in body.name:
		if body.life:
			body.die()
		else:
			pass
	if "Ball" in body.name:
		body.queue_free()

func _on_KillArea_body_exited(body):
	pass
