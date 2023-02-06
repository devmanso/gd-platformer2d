extends KinematicBody2D

onready var sprite = $Sprite
onready var collider = $CollisionShape2D
onready var animator = $AnimationPlayer


export var walkspeed = 200
export var jump_power = -800
export var gravity = 3000
export var acceleration = 0.25
export var friction = 0.1

var idle = true
var up
var right
var left
var jumps_made = 0
var velocity = Vector2.ZERO
var motion = Vector2.ZERO

const TARGET_FPS = 60
const ACCELERATION = 8
const MAX_SPEED = 64
const FRICTION = 10
const AIR_RESISTANCE = 1
const GRAVITY = 4
const JUMP_FORCE = 140



func get_input():
	var dir = 0
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
			
		
		

#func input():
#	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
#
#	if x_input != 0:
#		animator.play("walk")
#		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
#		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
#		sprite.flip_h = x_input < 0
#	else:
#		animator.play("RESET")
#
#	motion.y += GRAVITY * delta * TARGET_FPS
#
#	if is_on_floor():
#		if x_input == 0:
#			motion.x = lerp(motion.x, 0, FRICTION * delta)
#
#		if Input.is_action_just_pressed("jump"):
#			motion.y = -JUMP_FORCE
#	else:
#		animator.play("jump")
#
#		if Input.is_action_just_released("jump") and motion.y < -JUMP_FORCE/2:
#			motion.y = -JUMP_FORCE/2
#
#		if x_input == 0:
#			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)

#func get_input_and_do_animation():
#	var dir = 0
#	if Input.is_action_pressed("right"):
#		dir += 1
#		right = true
#		left = false
#		if right and !up:
#			animator.play("walking")
#		sprite.flip_h = false
#	if Input.is_action_pressed("left"):
#		dir -= 1
#		right = false
#		left = true
#		if left and !up:
#			animator.play("walking")
#		sprite.flip_h = true
#	if dir != 0:
#		#animator.play("RESET")
#		velocity.x = lerp(velocity.x, dir * walkspeed, acceleration)
#	else:
#		animator.play("RESET")
#		velocity.x = lerp(velocity.x, 0, friction)
#	if Input.is_action_pressed("jump"):
#		if is_on_floor():
#			right = false
#			left = false
#			up = true
#			if up:
#				animator.play("jump")
#			velocity.y = jump_power

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			right = false
			left = false
			idle = false
			animator.play("jump")
			velocity.y = jump_power
			up = false
			jumps_made +=1
		elif !is_on_floor():
			up = true
	if Input.is_action_just_released("jump"):
		idle = true
	
		

func _ready():
	animator.connect("animation_finished", self, "_on_jump_animation_finished")



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "jump":
		print("jump fin")
