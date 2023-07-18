extends Control

onready var timertext = $TimerText
onready var startTime = OS.get_ticks_msec()

func get_time():
	var current_time = OS.get_ticks_msec() - startTime
	return current_time

func _physics_process(delta):
	var speedruntime = get_time()
	#timertext.text = speedruntime
	var minutes = speedruntime /1000 /60
	var seconds = speedruntime /1000 %60
	var ms = speedruntime %1000 /100
	var timetext = str(minutes) + "m:" + str(seconds) + "s:" + str(ms) + "ms"
	timertext.text = timetext
	
