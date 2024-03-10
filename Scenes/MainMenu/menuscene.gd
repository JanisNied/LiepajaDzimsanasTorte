extends Spatial

var anim = false
var rulesRead = false
onready var animationplayer = $Camera/CameraAnim

func _ready():
	if not SaveSystem.has("SettingsGenerated"):
		var volumes : Dictionary = {"master" : 1.0,
									"music" : 0.2,
									"sfx" : 1.0}
		SaveSystem.set_var("SettingsGenerated", true)
		SaveSystem.set_var("WindowMode", "Windowed")
		SaveSystem.set_var("Resolution", Vector2(1024, 576))
		SaveSystem.set_var("Volumes", volumes)
		SaveSystem.save()
	print("[PERSISTENCE] Display Mode: ", SaveSystem.get_var("WindowMode"))
	print("[PERSISTENCE] Resolution: ", SaveSystem.get_var("Resolution"))
	print("[PERSISTENCE] Volume Dict: ", SaveSystem.get_var("Volumes"))			
	SoundManager.set_bgm_volume_db(linear2db(SaveSystem.get_var("Volumes")["music"] * SaveSystem.get_var("Volumes")["master"]))
	SoundManager.set_se_volume_db(linear2db(SaveSystem.get_var("Volumes")["sfx"] * SaveSystem.get_var("Volumes")["master"]))
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


