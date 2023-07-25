extends TileMap

export var hidden : bool = false


func _ready():
	if hidden:
		hide()
		disable_collision()
	else:
		enable_collision()
		show()

func enable_collision():
	var layer = get_collision_layer()
	var mask = get_collision_mask()
	for i in range(32):
		layer = layer | (1 << i)
	for i in range(32):
		mask = mask | (1 << i)
	set_collision_layer(layer)
	set_collision_mask(mask)


func disable_collision():
	var layer = get_collision_layer()
	var mask = get_collision_mask()
	for i in range(32):
		layer = layer & ~(1 << i)
	for i in range(32):
		mask = mask & ~(1 << i)
	set_collision_layer(layer)
	set_collision_mask(mask)
	
