extends StaticBody2D

onready var sprite = $Sprite

export var on : bool = false

var block
var canInteract : bool
var player

func _ready():
	player = get_parent().find_node("Player")
	block = get_node("Block")

func _on_InteractZone_body_entered(body):
	if "Player" in body.name:
		canInteract = true

func _process(delta):
	if canInteract and !on:
		if player.is_interact_pressed():
			block.canMove = false
			sprite.flip_h = true
			yield(get_tree().create_timer(.5), "timeout")
			on = true
	elif canInteract and on:
		if player.is_interact_pressed():
			block.canMove = true
			sprite.flip_h = false
			yield(get_tree().create_timer(.5), "timeout")
			on = false


func _on_InteractZone_body_exited(body):
	canInteract = false
