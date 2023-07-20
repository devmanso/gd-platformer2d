extends StaticBody2D

export var hiddenGroup = false


func handle_goal():
	if hiddenGroup:
		var hiddengroup = get_parent().find_node("HiddenGroup")
		hiddengroup.show()

func _on_Goal_body_entered(body):
	if "Ball" in body.name:
		handle_goal()
