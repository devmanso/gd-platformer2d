extends Sprite

onready var followArea = $FollowArea
onready var animation = $Animation

var followPlayer : bool = false
var player

func _ready():
	animation.play("idle")
	player = get_parent().find_node("Player")

func _process(delta):
	if followPlayer:
		position += (player.position - position) /50



func _on_FollowArea_body_entered(body):
	if "Player" in body.name:
		followPlayer = true
