extends Area2D

onready var sprite = $Sprite
export var next_scene = ""

func _ready():
	pass
	#sprite.hide()

func _on_SceneChanger_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(next_scene)
		
	else:
		return false
