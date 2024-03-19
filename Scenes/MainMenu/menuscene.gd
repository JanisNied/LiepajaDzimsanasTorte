extends Spatial

var anim = false
var rulesRead = false
onready var animationplayer = $Camera/CameraAnim

func _ready():
	SoundManager.stop("betweenDoors")
	SoundManager.play_bgm("sunMenuMusic")
	if Global.youwenttocustomgame:
		$Camera/CameraAnim.play("ZoomToTable")
		enableAreas()
	else:	
		animationplayer.play("Enter")
		disableAreas()
		yield(get_tree().create_timer(0.5), "timeout")
		anim = true;

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and anim:
		anim = false
		$RuleboardCreditBoard/Area.show()
		animationplayer.play("ZoomToTable")

func disableAreas():
	$PlaySelector/Area.hide()
	$SettingsSelector/Area.hide()
	$LeaderboardSelector/Area.hide()
	$AboutSelector/Area.hide()
	$Button/Area2.hide()
	$CakeDecor/Area.hide()
	
func enableAreas():
	$CakeDecor/Area.show()
	$PlaySelector/Area.show()
	$SettingsSelector/Area.show()
	$LeaderboardSelector/Area.show()
	$AboutSelector/Area.show()
	$Button/Area2.show()

# Custom Game
func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			Global.transition("tarot")
			Global.youwenttocustomgame = true
			disableAreas()
	pass # Replace with function body.


func _on_Area_mouse_entered():
	$CakeDecor/Teksts.emission_strength = 7.7
	$CakeDecor/SpotLight.show()
	pass # Replace with function body.


func _on_Area_mouse_exited():
	$CakeDecor/Teksts.emission_strength = 0
	$CakeDecor/SpotLight.hide()
	pass # Replace with function body.
