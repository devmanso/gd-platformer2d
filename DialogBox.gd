extends Control

onready var label = $RichTextLabel

export var dialog = [
	"Hello world"
]

var dialog_index = 0
var dialog_finished = false

func _ready():
	load_dialog()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		load_dialog()

# check if there is any dialog, if there is, then put the dialog data from that
# index, and store it in the label's text, then iterate through all indexes
# until done
func load_dialog():
	if dialog_index < dialog.size():
		label.text = dialog[dialog_index]
	else: queue_free()
	dialog_index += 1
