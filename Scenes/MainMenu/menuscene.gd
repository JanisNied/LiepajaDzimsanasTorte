extends Spatial

var anim = true

func _input(event):
	if event is InputEventKey and event.pressed and anim:
		anim = false
		$Camera/CameraAnim.play("ZoomToTable")
