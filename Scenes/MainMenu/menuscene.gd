extends Spatial

var anim = true
var rulesRead = false;
onready var animationplayer = $Camera/CameraAnim

func _ready():
	disableAreas()

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and anim:
		anim = false
		animationplayer.play("ZoomToTable")

func disableAreas():
	$PlaySelector/Area.hide()
	$SettingsSelector/Area.hide()
	$LeaderboardSelector/Area.hide()
	$AboutSelector/Area.hide()
	
func enableAreas():
	$PlaySelector/Area.show()
	$SettingsSelector/Area.show()
	$LeaderboardSelector/Area.show()
	$AboutSelector/Area.show()
