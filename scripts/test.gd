extends Node2D

export var on = false
var fonts = []

func _process(delta):
	if on:
		#print(fonts)
		var fontDirPath = "res://fonts/"
		var fontDir = Directory.new()
		if fontDir.open(fontDirPath) == OK:
			fontDir.list_dir_begin()
			var fileName = fontDir.get_next()
			while fileName != "":
				if fileName.get_extension().to_lower() == "ttf":
					var fontPath = fontDirPath + fileName
					load_font(fontPath)
				fileName = fontDir.get_next()
			fontDir.list_dir_end()
		else:
			print("Failed to open fonts directory")

func _physics_process(delta):
	if on:
		#print(fonts)
		var fontDirPath = "res://fonts/"
		var fontDir = Directory.new()
		if fontDir.open(fontDirPath) == OK:
			fontDir.list_dir_begin()
			var fileName = fontDir.get_next()
			while fileName != "":
				if fileName.get_extension().to_lower() == "ttf":
					var fontPath = fontDirPath + fileName
					load_font(fontPath)
				fileName = fontDir.get_next()
			fontDir.list_dir_end()
		else:
			print("Failed to open fonts directory")

func load_font(fontPath: String):
	var font = DynamicFont.new()
	var fontData = load(fontPath)
	if fontData:
		font.font_data = fontData
	else:
		print("Failed to load font:", fontPath)
