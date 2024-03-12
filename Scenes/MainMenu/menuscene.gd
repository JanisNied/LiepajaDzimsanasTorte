extends Spatial

const file_path : String = "user://leaderboard.json"

var anim = false
var rulesRead = false
onready var animationplayer = $Camera/CameraAnim

func _ready():
	animationplayer.play("Enter")
	SoundManager.play_bgm("sunMenuMusic")
	disableAreas()
	yield(get_tree().create_timer(0.5), "timeout")
	anim = true;

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