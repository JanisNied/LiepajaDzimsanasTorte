extends Control

export(String) var scene = "menuscene"
export(float) var fade_out_speed = 1.0
export(float) var fade_in_speed = 1.0
export(String) var fade_out_pattern = "scribbles"
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

func _ready():
	OS.set_window_size(str2var("Vector2" + str(SaveSystem.get_var("Resolution"))))
	center_window()
	if (SaveSystem.get_var("WindowMode") == "Fullscreen"):
		OS.window_fullscreen = true
	$ViewportContainer/Viewport/Coin/Teksts.hide()
	yield(get_tree().create_timer(1.0), "timeout")
	$ViewportContainer/Viewport/Coin/AnimationPlayer.play("COIN")
	yield(get_tree().create_timer(3.5), "timeout")
	SceneManager.validate_scene(scene)
	SceneManager.validate_pattern(fade_out_pattern)
	SceneManager.validate_pattern(fade_in_pattern)
	SceneManager.set_recorded_scene(scene)
	SceneManager.change_scene("loadscene", fade_out_options, fade_in_options, general_options)
	pass 

func center_window():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	var center_position = (screen_size - window_size) / 2
	OS.set_window_position(center_position)
