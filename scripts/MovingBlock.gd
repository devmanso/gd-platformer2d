extends StaticBody2D

onready var sprite = $Sprite

export var xUnitsMoved = 360
export var speed : float = 300
export var isYaxis : bool = true

var initPosition: Vector2
var rightEndPosition: Vector2
var leftEndPosition: Vector2
var isMoving : bool = false
var resetPosition : bool = false
var isAtEnd : bool = false

func _ready():
	sprite.hide()
	initPosition = position
	leftEndPosition = Vector2(initPosition.x - xUnitsMoved, initPosition.y)
	rightEndPosition = Vector2(initPosition.x + xUnitsMoved, initPosition.y)


func _physics_process(delta):
	if !isAtEnd:
		position.x += speed * delta
	elif isAtEnd:
		if position != initPosition:
			position.x -= speed * delta
		else:
			isAtEnd = false
		
	
	if speed > 0 and position.x >= rightEndPosition.x:
		position.x = rightEndPosition.x
		isAtEnd = true
	elif speed < 0 and position.x <= rightEndPosition.x:
		position.x = rightEndPosition.x
		isAtEnd = true
	
#	if speed > 0 and position.x >= leftEndPosition.x:
#		position.x = leftEndPosition.x
#		isAtEnd = false
#	elif speed < 0 and position.x <= leftEndPosition.x:
#		position.x = leftEndPosition.x
#		isAtEnd = false
	
	
