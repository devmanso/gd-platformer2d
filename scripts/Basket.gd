extends StaticBody2D

onready var redSprite = $RedSprite
onready var blueSprite = $BlueSprite

var pinkTiles

func handle_goal():
	pinkTiles.hide()
	pinkTiles.disable_collision()
	blueSprite.show()
	redSprite.hide()

func _ready():
	blueSprite.hide()
	redSprite.show()
	pinkTiles = get_parent().find_node("PinkCaveTMap")

func _on_Goal_body_entered(body):
	if "Ball" in body.name:
		handle_goal()
