extends Control

func _ready():
	pass
	
func _on_Button_pressed():
	if not SceneManager.is_transitioning:
		SceneManager.change_scene(
			'res://Scenes/LoadingScreen/Initialize.tscn', {"pattern_enter": "scribbles", "pattern_leave": "scribbles"}
		)
