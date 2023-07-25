extends StaticBody2D

var pinkTiles
var player
export var on : bool = false
var canInteract : bool
var doInteractCheck : bool

func _ready():
	pinkTiles = get_parent().find_node("PinkCaveTMap")
	player = get_parent().find_node("Player")

func _on_InteractZone_body_entered(body):
	if "Player" in body.name:
		canInteract = true
		print("player found")
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
	elif canInteract and on:
		if player.is_interact_pressed():
			pinkTiles.enable_collision()
			pinkTiles.show()


func _on_InteractZone_body_exited(body):
	canInteract = false
