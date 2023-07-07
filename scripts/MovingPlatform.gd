extends StaticBody2D

export var yUnitsMoved = 360
export var speed = 300
var initPosition: Vector2
var endPosition: Vector2
var isMoving = false

func _ready():
	initPosition = position
	endPosition = Vector2(initPosition.x, initPosition.y + yUnitsMoved)

func _process(delta):
	if isMoving:
		position.y += speed * delta
		if speed > 0 and position.y >= endPosition.y:
			position.y = endPosition.y
			isMoving = false
		elif speed < 0 and position.y <= endPosition.y:
			position.y = endPosition.y
			isMoving = false

func _on_ObjectDetector_body_entered(body):
	if "Player" in body.name:
		isMoving = true
