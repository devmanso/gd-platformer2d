extends Area2D

onready var sprite = $Sprite
onready var animationplayer = $AnimationPlayer
export var next_scene = ""
export var facingRight = true

func _ready():
	if !facingRight:
		sprite.flip_h

func _process(delta):
	animationplayer.play("Idle")

func _on_SceneChanger_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(next_scene)
		
	else:
		return false
