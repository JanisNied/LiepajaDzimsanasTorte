extends Spatial
onready var cameraAnimHandler = get_parent().get_node("Camera/CameraAnim")

func _ready():
	pass 


func _on_Area_mouse_entered():
	$Teksts.emission_strength = 1.35
	$cakeobj1/Outline.show()
	$Plate/plateoutline.show()
	$animplayer.play("FloatUp")
	pass 


func _on_Area_mouse_exited():
	$Teksts.emission_strength = 0
	$cakeobj1/Outline.hide()
	$Plate/plateoutline.hide()
	$animplayer.play_backwards("FloatUp")
	pass


func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Area.hide()
