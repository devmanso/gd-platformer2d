extends Node2D

onready var duration = $Duration
var has_dashed

func start_dash(duration_time):
	duration.wait_time = duration_time
	has_dashed = true
	duration.start()

func is_dashing():
	return !duration.is_stopped()
