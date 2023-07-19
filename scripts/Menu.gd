extends Node2D

onready var buttons = $Buttons

var screenWidth = OS.get_screen_size().x
var screenHeight = OS.get_screen_size().y

func _ready():
	buttons.position.x = screenWidth /2
	buttons.position.y = screenHeight /2
