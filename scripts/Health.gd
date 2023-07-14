extends Node2D
class_name Health

# The purpose of this component is to allow health functionality for things like
# enemies or players, while also being extensible

export var maxHP = 100
var hp : float

func _ready():
	hp = maxHP

func take_damage(amount : float):
	hp -= amount
	if hp <= 0:
		die()

# every node that extends from this component should have its own die() function
func die():
	pass
