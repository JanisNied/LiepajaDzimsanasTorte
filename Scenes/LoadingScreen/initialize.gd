extends Control

func _ready():
	SceneManager.connect("load_finished", self, "loading_finished")
	SceneManager.load_scene_interactive(SceneManager.get_recorded_scene())

func loading_finished() -> void:
	$EventHitbox.show()

func loadScene() -> void:
	var fade_out_options = SceneManager.create_options(1.0, "scribbles", 0.2, true)
	var fade_in_options = SceneManager.create_options(1.0, "scribbles", 0.2, true)
	var general_options = SceneManager.create_general_options(Color(0, 0, 0), 0, false, true)
	SceneManager.change_scene_to_loaded_scene(fade_out_options, fade_in_options, general_options)

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and $EventHitbox.is_visible_in_tree():
		$EventHitbox.hide()
		loadScene()
