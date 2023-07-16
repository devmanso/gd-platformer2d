extends Button

var ball = load("res://Ball.tscn")
export var spawnPosition : Vector2

func _on_BallSpawner_pressed():
	var ball_instance = ball.instance()
	ball_instance.position = spawnPosition
	get_tree().get_root().call_deferred("add_child", ball_instance)
