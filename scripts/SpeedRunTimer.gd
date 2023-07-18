extends Control

onready var timertext = $TimerText
onready var startTime = OS.get_ticks_msec()

export var doNotRun : bool = false

var speedruntime
var path
var clean_scene_name

func get_time():
	var current_time = OS.get_ticks_msec() - startTime
	return current_time

func _physics_process(delta):
	if !doNotRun:
		speedruntime = get_time()
		#timertext.text = speedruntime
		var minutes = speedruntime /1000 /60
		var seconds = speedruntime /1000 %60
		var ms = speedruntime %1000 /100
		var timetext = str(minutes) + "m:" + str(seconds) + "s:" + str(ms) + "ms"
		timertext.text = timetext
	else:
		timertext.text = "OFF"

func get_world():
	var scene_name = str(get_tree().current_scene)
	var start = scene_name.find("[")
	var end = scene_name.find("]")
	if start >= 0 and end >=0:
		clean_scene_name = scene_name.replace(
			scene_name.substr(start, end - start + 1), "")
	return clean_scene_name

func save(world : String, time : String):
	var save = File.new()
	save.open("user://save.txt", File.READ_WRITE)
	var storestring = world + " time:" +  time
	save.seek_end()
	save.store_string("\n")
	save.store_string(storestring)
#	path = save.get_path_absolute()
#	print(path)
	save.close()
