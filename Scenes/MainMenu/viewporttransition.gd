extends Spatial

export(String) var scene = "splashscene"
export(float) var fade_out_speed = 1.0
export(float) var fade_in_speed = 1.0
export(String) var fade_out_pattern = "pixel"
export(String) var fade_in_pattern = "fade"
export(float, 0, 1) var fade_out_smoothness = 0.1
export(float, 0, 1) var fade_in_smoothness = 0.1
export(bool) var fade_out_inverted = false
export(bool) var fade_in_inverted = false
export(Color) var color = Color(0, 0, 0)
export(float) var timeout = 0.0
export(bool) var clickable = false
export(bool) var add_to_back = true

onready var fade_out_options = SceneManager.create_options(fade_out_speed, fade_out_pattern, fade_out_smoothness, fade_out_inverted)
onready var fade_in_options = SceneManager.create_options(fade_in_speed, fade_in_pattern, fade_in_smoothness, fade_in_inverted)
onready var general_options = SceneManager.create_general_options(color, timeout, clickable, add_to_back)

func transition():
	SceneManager.validate_scene(scene)
	SceneManager.validate_pattern(fade_out_pattern)
	SceneManager.validate_pattern(fade_in_pattern)
	SceneManager.set_recorded_scene(scene)
	SceneManager.change_scene("loadscene", fade_out_options, fade_in_options, general_options)
	pass 

