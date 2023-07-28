extends StaticBody2D

onready var sprite = $Sprite

export var xUnitsMoved = 360
export var speed : float = 300
export var leftAndRight : bool = true


var canMove : bool = true
var initPosition : Vector2
var rightEndPosition : Vector2
var leftEndPosition : Vector2
var upEndPosition : Vector2
var resetPosition : bool = false
var isAtEnd : bool = false

func _ready():
	sprite.hide()
	initPosition = position
	upEndPosition = Vector2(initPosition.x, initPosition.y + xUnitsMoved)
	leftEndPosition = Vector2(initPosition.x - xUnitsMoved, initPosition.y)
	rightEndPosition = Vector2(initPosition.x + xUnitsMoved, initPosition.y)


func _physics_process(delta):
	
	if canMove:
		if leftAndRight:
			
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
			
		elif !leftAndRight:
			
			if !isAtEnd:
				position.y += speed * delta
			elif isAtEnd:
				if position != initPosition:
					position.y -= speed * delta
				else:
					isAtEnd = false
			
		if speed > 0 and position.y >= upEndPosition.y:
			position.y = upEndPosition.y
			isAtEnd = true
		elif speed < 0 and position.y <= upEndPosition.y:
			position.y = upEndPosition.y
			isAtEnd = true
