extends KinematicBody2D

#note to self:
# credit https://penzilla.itch.io/hooded-protagonist
# in a README file
# before uploading to git

onready var sprite = $Sprite
onready var collider = $CollisionShape2D
onready var animator = $AnimationPlayer
onready var health = $Health
onready var deathscreen = $DeathScreen
onready var dash = $Dash
onready var respawnbutton = $buttons/RespawnButton
onready var menubutton = $buttons/GiveUp
onready var camera = $Cam
onready var buttons = $buttons

export var walkspeed = 300
export var jump_power = -1000
export var acceleration = 0.25
export var friction = 0.1
export var gravity = 2500
export var death_text = [
	"You are dead!",
	"HAHAHAHAHAHA",
	"HAHAHAHAHAHAHHAHAHHAHHAHAHAHAHAHHAHHAHHAHHAHAHHAHAHHAHAA",
	"Try again?",
	"This text is randomized -_-",
	":(",
	"walrus gaming :<",
	"press Alt+F4 to activate cheats",
	"https://youtu.be/dQw4w9WgXcQ"
]
export var dashspeed = 1000.0
export var duration = .2
export var maxAirDashes = 1

const airDashBoost = 3

#var facing
#var dashSpeed = 1000
var canDash = true
var airDash = 0
#var dashing = false
#var dashDirection = Vector2.ZERO
var inversed_jump_power = -1 * jump_power
var can_play_jump_anim
var idle = true
var up
var right
var left
var is_attacking
var jumps_made = 0
var velocity = Vector2.ZERO
var motion = Vector2.ZERO
var upsideDown = false
var spawnpoint
var life = true
var rng = RandomNumberGenerator.new()
var text_to_show
var death_text_id
var deaths = 0
var switchCounter = 0
var isInteracting : bool
var tileSwitch
var hasKey : bool = false
var mousePosition : Vector2
var camTargetPosition : Vector2
var buttonPosition : Vector2


func flip_gravity():
	gravity = -2500
	upsideDown = true
	sprite.flip_v = true

func release_gravity():
	gravity = 2500
	upsideDown = false
	sprite.flip_v = false
	jump_power = -900

#
#func resetAirDash():
#	yield(get_tree().create_timer(.5), "timeout")
#	airDash = true

func is_even(num):
	if num %2 == 0:
		return true
	else:
		return false

func camera():
	mousePosition = get_viewport().get_mouse_position()
	camTargetPosition = get_global_transform().affine_inverse().xform(mousePosition)
	camera.global_position = camTargetPosition

func input(delta):
	
	var currentSpeed = dashspeed if dash.is_dashing() else walkspeed
	
	if Input.is_action_just_pressed("dash") and !dash.has_dashed:
		dash.start_dash(duration)
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
#	if Input.is_action_just_pressed("gravity"):
#		if !is_even(switchCounter) or switchCounter == 0:
#			flip_gravity()
#			switchCounter += 1
#		else:
#			switchCounter +=1
#			release_gravity()
	
	if Input.is_action_pressed("right"):
		velocity.x = currentSpeed #walkspeed
		animator.play("walking")
		sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -currentSpeed #walkspeed
		sprite.flip_h = true
		animator.play("walking")
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)
		animator.play("RESET")
	
	if !is_on_floor() and !is_on_ceiling():
		animator.play("single_frame_jump")
	
	
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_power
		elif is_on_ceiling():
			velocity.y = inversed_jump_power
		elif Input.is_action_just_pressed("dash") and airDash <maxAirDashes:
			
			if Input.is_action_just_pressed("dash"):
				airDash +=1
			
			if Input.is_action_pressed("right"):
				velocity.x = currentSpeed
				velocity.y = -currentSpeed * airDashBoost
			elif Input.is_action_pressed("left"):
				velocity.x = -currentSpeed
				velocity.y = -currentSpeed * airDashBoost
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	

func is_interact_pressed():
	return Input.is_action_pressed("interact")

func _physics_process(delta):
	if is_on_floor():
		dash.has_dashed = false
		airDash = 0
	if is_on_ceiling():
		dash.has_dashed = false
		airDash = 0
	if life:
		input(delta)
		#camera()
	if health.hp <= 0:
		die()
		life = false
	

func _process(delta):
	buttonPosition = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
	#buttons.position = buttonPosition
	#buttons.position = buttonPosition
	
	if life:
		is_interact_pressed()
	if !life:
		if Input.is_action_pressed("test"):
			respawn()
		

func _ready():
	life = true
	deathscreen.hide()
	respawnbutton.hide()
	menubutton.hide()

func respawn():
	release_gravity()
	spawnpoint = get_parent().find_node("SpawnPoint")
	position = spawnpoint.position
	life = true
	deathscreen.hide()
	menubutton.hide()
	respawnbutton.hide()
	get_tree().reload_current_scene()

func die():
	life = false
	death_text_id = rng.randi_range(0, death_text.size() -1)
	text_to_show = death_text[death_text_id]
	deathscreen.text = text_to_show
	deathscreen.show()
	menubutton.show()
	respawnbutton.show()
	animator.play("dead")
	deaths +=1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "dead":
		pass


func _on_RespawnButton_pressed():
	if !life:
		respawn()


func _on_GiveUp_pressed():
	get_tree().change_scene("res://Menu.tscn")
