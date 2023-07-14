extends KinematicBody2D

#note to self:
# credit https://penzilla.itch.io/hooded-protagonist
# in a README file
# before uploading to git

onready var sprite = $Sprite
onready var collider = $CollisionShape2D
onready var animator = $AnimationPlayer
onready var health = $Health

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
	kb_input()
	if health.hp <= 0:
		die()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)
	
	

func die():
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "jump":
		print("jump fin")
