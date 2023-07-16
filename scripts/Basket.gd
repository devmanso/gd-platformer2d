extends StaticBody2D

func _on_Goal_body_entered(body):
	if "Ball" in body.name:
		var hiddengroup = get_parent().find_node("HiddenGroup")
		hiddengroup.show()
