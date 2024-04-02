extends Spatial



var begin = false
func _ready():
	yield(get_tree().create_timer(1.5), "timeout")
	SoundManager.play_se("begingame")
	$Tutorial.show()
	yield(get_tree().create_timer(1.5), "timeout")
	begin = true
	pass # Replace with function body.


func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and begin:
		begin = false
		$Tutorial.hide()
		$Player.pda1 = true
		$Player.movement = true
		$Player.flashlightenabled = true
		$Player/Flashlight/FlashLightMesh/SpotLight.visible = !$Player/Flashlight/FlashLightMesh/SpotLight.visible
		$Player.flashlight_sound.play()
		$Events/EventTimer.autostart = true
		$Events/EventTimer.start()
		SoundManager.play_bgm("ambiencetrain", 0.0, -15.0)
