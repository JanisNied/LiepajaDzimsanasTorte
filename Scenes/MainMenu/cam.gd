extends Camera

var maxMoveSpeed = 10.0 
var sensitivity = 0.1 

var moveBounds : Rect2 

func _process(delta):
	var viewport = get_viewport()
	moveBounds = Rect2(-get_viewport().size.x / 2, -get_viewport().size.y / 2, get_viewport().size.x, get_viewport().size.y)

	var mouse_pos = viewport.get_mouse_position()
	var move_x = ((mouse_pos.x - viewport.get_size().x / 2) / viewport.get_size().x) * maxMoveSpeed * sensitivity
	var move_y = -((mouse_pos.y - viewport.get_size().y / 2) / viewport.get_size().y) * maxMoveSpeed * sensitivity
	translate(Vector3(move_x, move_y, 0) * delta)

	var camera_position = global_transform.origin
	camera_position.x = clamp(camera_position.x, moveBounds.position.x, moveBounds.position.x + moveBounds.size.x)
	camera_position.y = clamp(camera_position.y, moveBounds.position.y, moveBounds.position.y + moveBounds.size.y)
	global_transform.origin = camera_position
	
