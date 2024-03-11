extends MeshInstance

func _ready():
	pass 

func _on_Area2_mouse_entered():
	get_parent().get_node("Button/Outline").show()
	$Teksts.emission_strength = 1.35
	pass


func _on_Area2_mouse_exited():
	get_parent().get_node("Button/Outline").hide()
	$Teksts.emission_strength = 0
	pass 


func _on_Area2_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			SaveSystem.save()
			get_tree().quit()
	pass
