extends StaticBody2D

onready var sprite = $Sprite

export var on : bool = false

var blockGroup
var canInteract : bool
var player

func _ready():
	player = get_parent().find_node("Player")
	blockGroup = get_parent().find_node("BlockGroup")

func _on_InteractZone_body_entered(body):
	if "Player" in body.name:
		canInteract = true

func _process(delta):
	if canInteract and !on:
		if player.is_interact_pressed():
			# find all child nodes of blockGroup and call canMove on them
			sprite.flip_h = true
	elif canInteract and on:
		if player.is_interact_pressed():
			
			sprite.flip_h = true

func _on_InteractZone_body_exited(body):
	canInteract = false
