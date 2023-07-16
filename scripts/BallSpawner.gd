extends Button

var ball = load("res://Ball.tscn")

func _on_BallSpawner_pressed():
	var ball_instance = ball.instance()
	get_tree().get_root().call_deferred("add_child", ball_instance)
