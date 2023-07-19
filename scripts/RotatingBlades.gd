extends Node2D

onready var blades = $Blades
onready var path = get_parent()

export var isOnPath = false
export var pathFollowSpeed = 200.0
export var bladeSpeed = 0.1
var t = 0.0

func _ready():
	if isOnPath:
		path.rotate = false

func _physics_process(delta):
	if isOnPath:
		t+= delta
		rotation += bladeSpeed
		path.offset = t* pathFollowSpeed
	else:
		rotation += bladeSpeed
