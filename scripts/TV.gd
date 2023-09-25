extends Area2D

export var on : bool = false

var block
var canInteract : bool
var player

func _ready():
	player = get_parent().find_node("Player")

func _process(delta):
	if canInteract and !on:
		if player.is_interact_pressed():
			player.deathscreen.text = "rad flick"
			player.deathscreen.show()
			yield(get_tree().create_timer(3), "timeout")
			player.deathscreen.hide()
			on = true
	elif canInteract and on:
		if player.is_interact_pressed():
			player.deathscreen.text = "rad flick"
			player.deathscreen.show()
			yield(get_tree().create_timer(3), "timeout")
			player.deathscreen.hide()
			on = false

func _on_TV_body_entered(body):
	if "Player" in body.name:
		canInteract = true


func _on_TV_body_exited(body):
	canInteract = false
