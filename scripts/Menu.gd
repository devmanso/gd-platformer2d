extends Node2D

onready var buttons = $Buttons

func _process(delta):
	var screenWidth = get_viewport_rect().size.x
	var screenHeight = get_viewport_rect().size.y
	buttons.position.x = screenWidth /2
	buttons.position.y = screenHeight /2
