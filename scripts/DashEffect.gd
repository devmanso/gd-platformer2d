extends Tween

onready var tween = $"." # script is attached to tween

# as soon as it's spawned, we want it to fade out
# use opacity property (modulate a)

func _ready():
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.5, 3, 1)
	tween.start()
