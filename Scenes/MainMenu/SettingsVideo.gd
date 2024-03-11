extends Control

var Resolutions: Dictionary = {"3840x2160":Vector2(3840,2160),
								"2560x1440":Vector2(2560,1080),
								"1920x1080":Vector2(1920,1080),
								"1600x900":Vector2(1600,900),
								"1366x768":Vector2(1366,768),
								"1280x720":Vector2(1280,720),
								"1024x576":Vector2(1024,576)}

func _ready():
	yield(get_tree().create_timer(1.5), "timeout")
	if SaveSystem.get_var("WindowMode") == "Fullscreen":
		$OptionButton._select_int(1)
		$ResolutionOptions.disabled = true
	AddResolutions()


func AddResolutions():
	var screen_size = OS.get_screen_size();
	var index = 0	
	for r in Resolutions:
		var addRes = false
		if screen_size.x > Resolutions[r].x and screen_size.y > Resolutions[r].y:
			addRes = true
		if addRes:
			$ResolutionOptions.add_item(r, index)
			if str(Resolutions[r]) == str(SaveSystem.get_var("Resolution")):
				$ResolutionOptions._select_int(index)
			index += 1


func _on_ResolutionOptions_item_selected(index):
	var size = Resolutions.get($ResolutionOptions.get_item_text(index))
	SaveSystem.set_var("Resolution", size)
	SaveSystem.save()
	OS.set_window_size(size)
	OS.center_window()


func _on_OptionButton_item_selected(index):
	match $OptionButton.get_item_text(index):
		"Windowed":
			SaveSystem.set_var("WindowMode", "Windowed")
			SaveSystem.save()
			OS.window_fullscreen = false
			$ResolutionOptions.disabled = false;
		"Fullscreen":
			SaveSystem.set_var("WindowMode", "Fullscreen")
			SaveSystem.save()
			OS.window_fullscreen = true	
			$ResolutionOptions.disabled = true;
	pass
