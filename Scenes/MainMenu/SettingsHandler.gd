extends Spatial

func _ready():
	pass 

func _selectVideo():
	get_node("Video").modulate = Color(0.13, 1.0, 0.33)
	get_node("Audio").modulate = Color(0.21, 0.21, 0.21)
	$Video/Holder.show()
	$Video/Holder/SettingsUI.show()
	$VideoArea/VideoScribble.hide()
	$VideoArea.hide()
	$AudioArea.show()
	$Audio/Holder.hide()
	$Audio/Holder/SettingsUI.hide()
	pass
	
func _selectAudio():
	get_node("Audio").modulate = Color(0.13, 1.0, 0.33)
	get_node("Video").modulate = Color(0.21, 0.21, 0.21)
	$Audio/Holder.show()
	$Video/Holder.hide()
	$Audio/Holder/SettingsUI.show()
	$AudioArea.hide()
	$VideoArea.show()
	$AudioArea.hide()
	$Video/Holder/SettingsUI.hide()
	pass		

func _hideEverything():
	get_node("Video").modulate = Color(0.21, 0.21, 0.21)
	get_node("Audio").modulate = Color(0.21, 0.21, 0.21)
	$VideoArea.hide()
	$AudioArea.hide()
	$Audio/Holder.hide()
	$Video/Holder.hide()
	$Video/Holder/SettingsUI.hide()
	$Audio/Holder/SettingsUI.hide()
	pass

func _on_VideoArea_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
				_selectVideo()
	pass


func _on_VideoArea_mouse_entered():
	$VideoArea/VideoScribble.show()
	pass 


func _on_VideoArea_mouse_exited():
	$VideoArea/VideoScribble.hide()
	pass


func _on_AudioArea_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
				_selectAudio()
	pass 


func _on_AudioArea_mouse_entered():
	$AudioArea/AudioScribble.show()
	pass # Replace with function body.


func _on_AudioArea_mouse_exited():
	$AudioArea/AudioScribble.hide()
	pass # Replace with function body.


func _on_Return2_mouse_entered():
	$Return2/ReturnScribble.show()
	pass


func _on_Return2_mouse_exited():
	$Return2/ReturnScribble.hide()
	pass

func _makeAvailable():
	$VideoArea.show()
	$AudioArea.show()
	
func _on_Return2_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
				_hideEverything()
				get_parent().get_parent().get_node("Camera/CameraAnim").play("ZoomBackFromNotebookSettings")
	pass # Replace with function body.
