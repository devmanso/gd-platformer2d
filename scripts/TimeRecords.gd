extends Node2D

onready var title = $Title
onready var records = $Records
var content

func loadRecords():
	var file = File.new()
	file.open("user://save.txt", File.READ)
	content = file.get_as_text()
	file.close()
	return content

func _process(delta):
	
	records.text = loadRecords()


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://Menu.tscn")
