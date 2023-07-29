extends StaticBody2D

onready var sprite = $Sprite
export var on : bool = false
var pinkTiles
var player
var canInteract : bool
var doInteractCheck : bool

func _ready():
	pinkTiles = get_parent().find_node("PinkCaveTMap")
	player = get_parent().find_node("Player")

func _on_InteractZone_body_entered(body):
	if "Player" in body.name:
		canInteract = true
		#print("player found")
#		if !on:
#			if player.is_interact_pressed():
#				pinkTiles.disable_collision()
#				print("on")
#		if on:
#			if player.is_interact_pressed():
#				pinkTiles.enable_collision()
#				print("off")

func _process(delta):
	if canInteract and !on:
		if player.is_interact_pressed():
			pinkTiles.disable_collision()
			pinkTiles.hide()
			sprite.flip_h = true
	elif canInteract and on:
		if player.is_interact_pressed():
			pinkTiles.enable_collision()
			pinkTiles.show()
			sprite.flip_h = true

func turnOn():
	pinkTiles.enable_collision()
	pinkTiles.show()

func turnOff():
	pinkTiles.disable_collision()
	pinkTiles.hide()

func _on_InteractZone_body_exited(body):
	canInteract = false
