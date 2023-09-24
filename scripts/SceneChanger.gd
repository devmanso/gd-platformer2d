extends Area2D

onready var sprite = $Sprite
onready var animationplayer = $AnimationPlayer
export var next_scene = ""
export var facingRight = true

var isClosed : bool
var speedrun

func _ready():
	if !facingRight:
		sprite.flip_h

func _process(delta):
	if !isClosed:
		animationplayer.play("Idle")

func saveToDisk():
	speedrun = get_parent().find_node("SpeedRunTimer")
	var currentWorld = str(speedrun.get_world() )
	var time = str(speedrun.speedruntime )
	speedrun.save(currentWorld, time)
	

func _on_SceneChanger_body_entered(body):
	if body.name == "Player":
		if body.hasKey:
			saveToDisk()
			animationplayer.play("close")
			isClosed = true
			var player = get_parent().find_node("Player")
			player.hide()
			player.camera.current = false
			yield(get_tree().create_timer(.85), "timeout")
			get_tree().change_scene(next_scene)
	else:
		return false
