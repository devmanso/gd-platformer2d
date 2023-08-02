extends StaticBody2D

var pinkTiles

func handle_goal():
	pinkTiles.hide()
	pinkTiles.disable_collision()

func _ready():
	pinkTiles = get_parent().find_node("PinkCaveTMap")

func _on_Goal_body_entered(body):
	if "Ball" in body.name:
		handle_goal()
