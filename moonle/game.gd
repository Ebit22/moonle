extends Node3D

var rotating := false
var last_mouse_position := Vector2()
@onready var target_mesh = $MeshInstance3D  # Zorg dat dit pad juist is

func _ready() -> void:
	$"pop-up".hide()

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			rotating = true
			last_mouse_position = event.position
		else:
			rotating = false

	elif event is InputEventMouseMotion and rotating:
		var delta = event.position - last_mouse_position
		last_mouse_position = event.position

		target_mesh.rotate(Vector3.UP, delta.x * 0.01)
		target_mesh.rotate(Vector3.RIGHT, delta.y * 0.01)
