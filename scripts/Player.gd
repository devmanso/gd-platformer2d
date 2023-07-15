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

export var walkspeed = 300
export var jump_power = -900
export var acceleration = 0.25
export var friction = 0.1
export var gravity = 2500

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
var death_text = [
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

func flip_gravity():
	gravity = -2500
	upsideDown = true
	sprite.flip_v = true

func release_gravity():
	gravity = 2500
	upsideDown = false
	sprite.flip_v = false
	jump_power = -900

func get_input():
	var dir = 0
	
	if Input.is_action_pressed("gravity"):
		flip_gravity()
	
#	if Input.is_action_pressed("attack"):
#		right = false
#		left = false
#		idle = false
#		is_attacking = true
#		if is_attacking:
#			animator.play("instant_attack")
#	if Input.is_action_just_released("attack"):
#		idle = true
#		is_attacking = false
	if Input.is_action_pressed("right"):
		dir += 1
		right = true
		left = false
		if right:
			animator.play("walking")
		sprite.flip_h = false
	if Input.is_action_pressed("left"):
		dir -= 1
		right = false
		left = true
		if left:
			animator.play("walking")
		sprite.flip_h = true
	if dir != 0:
		#animator.play("RESET")
		velocity.x = lerp(velocity.x, dir * walkspeed, acceleration)
	if dir == 0:
		if idle:
			animator.play("RESET")
#		if up:
#			animator.play("jump")
#		elif !up:
#			animator.play("RESET")
		velocity.x = lerp(velocity.x, 0, friction)
	

func kb_input():
	
	if Input.is_action_pressed("gravity"):
		flip_gravity()
	
	if Input.is_action_pressed("release"):
		release_gravity()
	
	if Input.is_action_pressed("right"):
		velocity.x = walkspeed
		animator.play("walking")
		sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -walkspeed
		sprite.flip_h = true
		animator.play("walking")
	else:
		animator.play("RESET")
	
	if !is_on_floor() and !is_on_ceiling():
		animator.play("single_frame_jump")
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power
	elif Input.is_action_pressed("jump") and is_on_ceiling():
		velocity.y = inversed_jump_power
	

func _physics_process(delta):
	if life:
		kb_input()
	if health.hp <= 0:
		die()
		life = false
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)

func _process(delta):
	if !life:
		if Input.is_action_pressed("test"):
			respawn()

func _ready():
	life = true
	deathscreen.hide()

func respawn():
	spawnpoint = get_parent().find_node("SpawnPoint")
	position = spawnpoint.position
	life = true
	deathscreen.hide()

func die():
	life = false
	death_text_id = rng.randi_range(0, death_text.size() -1)
	text_to_show = death_text[death_text_id]
	deathscreen.text = text_to_show
	deathscreen.show()
	deaths +=1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "jump":
		print("jump fin")
