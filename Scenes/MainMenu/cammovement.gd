extends Camera

const smooth_lean := 10.0
const scale_lean  := 0.2

var offset: Vector3 = Vector3.ZERO

func lean_camera_towards_mouse(delta:float) -> void:
	var mouse_position := get_viewport().get_mouse_position()
	
	var ray_origin := project_ray_origin(mouse_position)
	var ray_end := ray_origin + get_transform().basis.z * 1000.0  # Adjust the distance as needed
	
	var space_state := get_world().direct_space_state
	var result := space_state.intersect_ray(ray_origin, ray_end)
	
	if result:
		var lean := (result.position - get_translation()) * scale_lean
		offset = offset.linear_interpolate(lean, delta * smooth_lean)

func match_player_position() -> void:
	var player_node = get_node("../player")
	if player_node:
		set_translation(player_node.translation)

func _process(delta) -> void:
	lean_camera_towards_mouse(delta)
	match_player_position()
	set_translation(get_translation() + offset)
