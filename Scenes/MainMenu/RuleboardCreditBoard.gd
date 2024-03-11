extends MeshInstance


func _ready():
	pass 


func _on_Area_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_parent().get_node("Camera/CameraAnim").play("BackFromBoard")
	pass


func _on_Area_mouse_entered():
	$Arrow.modulate = Color(0.13, 1.0, 0.33)
	pass


func _on_Area_mouse_exited():
	$Arrow.modulate = Color(0.21, 0.21, 0.21)
	pass
