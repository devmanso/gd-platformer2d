extends Node2D

onready var followArea = $FollowArea
onready var animation = $Animation
onready var sprite = $Sprite

export var followspeed : float = 10
export var fadeOutDuration : float = 2.0

var followPlayer : bool = false
var player
var distanceFromPlayer
var used : bool = false
var fadeOutTimer : float = 0.0

func _ready():
	animation.play("idle")
	player = get_parent().find_node("Player")

func _physics_process(delta):
	
	if sprite.modulate.a == 0.0:
		queue_free()
	
	if used:
		fadeOutTimer += delta
		# Calculate the new opacity using the fadeOutTimer and fadeOutDuration
		var newOpacity = lerp(1.0, 0.0, fadeOutTimer / fadeOutDuration)
		sprite.modulate.a = newOpacity
		# Check if the fade-out is complete
		if fadeOutTimer >= fadeOutDuration:
			fadeOutTimer = 0.0
			used = false
			followPlayer = false
			player.hasKey = false
			sprite.modulate.a = 0.0
			animation.play("idle")
	
	distanceFromPlayer = abs(position.x - player.position.x)
	if followPlayer and !used:
		player.hasKey = true
		position += (player.position - position) /followspeed


func _on_FollowArea_body_entered(body):
	if "Player" in body.name:
		followPlayer = true
		player.hasKey = true

