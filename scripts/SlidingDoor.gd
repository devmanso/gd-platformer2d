extends StaticBody2D

export var yUnitsMoved = -360
export var speed = -300
export var isYaxis = true

var key
var player
var initPosition: Vector2
var endPosition: Vector2
var isMoving = false
var resetPosition = false

func _ready():
	player = get_parent().find_node("Player")
	key = get_parent().find_node("Key")
	initPosition = position
	if isYaxis:
		endPosition = Vector2(initPosition.x, initPosition.y + yUnitsMoved)
	else:
		endPosition = Vector2(initPosition.x + yUnitsMoved, initPosition.y)
	
#	if isNegative and isYaxis:
#		endPosition = Vector2(initPosition.x, initPosition.y - yUnitsMoved)
#	elif isNegative and !isYaxis:
#		endPosition = Vector2(initPosition.x - yUnitsMoved, initPosition.y)

func _process(delta):
	if isYaxis:
		if isMoving:
			position.y += speed * delta
			if speed > 0 and position.y >= endPosition.y:
				position.y = endPosition.y
				isMoving = false
			elif speed < 0 and position.y <= endPosition.y:
				position.y = endPosition.y
				isMoving = false
	else:
		if isMoving:
			position.x += speed * delta
			if speed > 0 and position.x >= endPosition.x:
				position.x = endPosition.x
				isMoving = false
			elif speed < 0 and position.x <= endPosition.x:
				position.x = endPosition.x
				isMoving = false
	if resetPosition:
		if !isMoving:
			position = initPosition



func _on_KeyChecker_body_entered(body):
	print(body.name)
	if "Player" in body.name:
		if player.hasKey:
			isMoving = true
			key.used = true
			player.hasKey = false
