extends StaticBody2D

onready var redSprite = $RedSprite
onready var blueSprite = $BlueSprite

var pinkTiles
var ballLeft : bool
var playerLeft : bool

func handle_goal():
	pinkTiles.hide()
	pinkTiles.disable_collision()
	blueSprite.show()
	redSprite.hide()

func reset():
	pinkTiles.show()
	pinkTiles.enable_collision()
	blueSprite.hide()
	redSprite.show()

func _ready():
	blueSprite.hide()
	redSprite.show()
	pinkTiles = get_parent().find_node("PinkCaveTMap")

func _on_Goal_body_entered(body):
	if "Player" in body.name:
		handle_goal()
		playerLeft = false
	elif "Ball" in body.name:
		handle_goal()
		ballLeft = false

func _on_Goal_body_exited(body):
	if "Player" in body.name:
		playerLeft = true
	elif "Ball" in body.name:
		ballLeft = true
	

func _process(delta):
	if ballLeft and playerLeft:
		reset()
