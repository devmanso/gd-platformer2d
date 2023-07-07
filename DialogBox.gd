extends Control

# adapted from https://www.youtube.com/watch?v=kkLqW8WhCgg

onready var label = $Control/RichTextLabel
onready var tween = $Control/Tween
onready var texture_rect = $Control/TextureRect

export var enable_text_animation = true

export var dialog = [
	"Hello world"
]

var dialog_index = 0
var dialog_finished = false

func _ready():
	load_dialog()

func _process(delta):
	if Input.is_action_just_pressed("skip_text"):
		load_dialog()

func animate_text(var enabled):
	if enabled:
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
	if !enabled:
		pass

# check if there is any dialog, if there is, then put the dialog data from that
# index, and store it in the label's text, then iterate through all indexes
# until done
func load_dialog():
	if dialog_index < dialog.size():
		label.text = dialog[dialog_index]
		animate_text(enable_text_animation)
	else: queue_free(); dialog_finished = true
	dialog_index += 1
