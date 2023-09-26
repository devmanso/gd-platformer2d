extends KinematicBody2D

onready var sprite = $Sprite
onready var animation = $Animation
onready var hitbox = $HitBox
onready var timer = $Timer

var state = "idle"
var rng = RandomNumberGenerator.new()
var coin 

func _process(delta):
	pass

func _ready():
	rng.seed = OS.get_unix_time()
	timer.start()

func _on_Timer_timeout():
	if state == "idle":
		state = "licking"
		coin = rng.randi_range(0,3)
		if coin == 1:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		animation.play("licking")
		
		timer.wait_time = 5.0
	else:
		state = "idle"
		coin = rng.randi_range(0,3)
		if coin == 1:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		animation.play("idle")
		
		timer.wait_time = 10.0
	timer.start()
	timer.one_shot = true
