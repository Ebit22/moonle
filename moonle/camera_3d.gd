extends MeshInstance3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var zoom_factor = Gb.value
	scale = Vector3(zoom_factor, zoom_factor, zoom_factor)
