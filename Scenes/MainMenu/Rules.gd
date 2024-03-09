extends Spatial

func _on_YesArea_mouse_entered():
	$NoPrompt/Scribble2.hide()
	$YesPrompt/Scribble.show()


func _on_YesArea_mouse_exited():
	$NoPrompt/Scribble2.hide()
	$YesPrompt/Scribble.hide()


func _on_NoArea_mouse_entered():
	$NoPrompt/Scribble2.show()
	$YesPrompt/Scribble.hide()


func _on_NoArea_mouse_exited():
	$NoPrompt/Scribble2.hide()
	$YesPrompt/Scribble.hide()
	pass 


func _on_NoArea_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			hide()
			get_parent().get_parent().get_node("Camera/CameraAnim").play("BackFromNotebook")
			get_parent().get_parent().enableAreas()
	pass 
