extends Control

# adapted from https://www.youtube.com/watch?v=kkLqW8WhCgg

onready var label = $RichTextLabel
onready var tween = $Tween
onready var texture_rect = $TextureRect

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

func animate_text():
	tween.interpolate_property(
		label, # Node selected
		"percent_visible", # selected property of node
		0, 1, # from, to
		1, # time (in sec)
		
		# effects
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.start()

# check if there is any dialog, if there is, then put the dialog data from that
# index, and store it in the label's text, then iterate through all indexes
# until done
func load_dialog():
	if dialog_index < dialog.size():
		label.text = dialog[dialog_index]
		animate_text()
	else: queue_free(); dialog_finished = true
	dialog_index += 1
