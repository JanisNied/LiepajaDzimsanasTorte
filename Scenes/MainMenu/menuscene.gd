extends Spatial

var anim = true
var rulesRead = false
var nightenv = load("res://NightSky.tres")
var init = false
var nightmusic = true
var daymusic = true


var time = "day"
var dayenv = load("res://Scenes/MainMenu/BeachEnv.tres")

onready var animationplayer = $Camera/CameraAnim

func _ready():
	SoundManager.stop("betweenDoors")
	checkTime()
	if Global.youwenttocustomgame:
		$Camera/CameraAnim.play("ZoomToTable")
		$RuleboardCreditBoard/Area.show()
		enableAreas()
		init = not Global.youwenttocustomgame
	else:	
		animationplayer.play("Enter")
		disableAreas()
		yield(get_tree().create_timer(0.5), "timeout")
		anim = true;
		init = true

func _process(delta):
	pass	
			
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


func _on_CheckDate_timeout():
	print("[TIME] Ping!")
	checkTime()
	
func checkTime():
	var num = int(Time.get_time_string_from_system(false).substr(0,2))
	if (0 <= num and num < 5):
		if nightmusic:
			init = true
			if not anim and init and not $Namebook/Settings.visible and not $Namebook/Ready.visible and not $Namebook/Rules.visible and $LeaderboardSelector/Area.visible and $Camera.fov == 70:
				anim = true
				animationplayer.play("ZoomToTable 2")
			$Candles/MeshInstance.show()
			$Candles2/MeshInstance2.show()	
			daymusic = true
			time = "night"
			$CakeDecor/SpotLight.light_energy = 1.519
			$CakeDecor/SpotLight.light_color = Color(0.15, 0.26, 0.69)
			$Environment/WorldEnvironment/Day.hide()
			$Environment/WorldEnvironment/Night.show()
			$Environment/WorldEnvironment.environment = nightenv
			SoundManager.play_bgm("days")
			SoundManager.stop("sunMenuMusic")
			nightmusic = false
	else:
		if daymusic:
			init = true
			if not anim and init and not $Namebook/Settings.visible and not $Namebook/Ready.visible and not $Namebook/Rules.visible and $LeaderboardSelector/Area.visible and $Camera.fov == 70:
				anim = true
				animationplayer.play("ZoomToTable 2")
			nightmusic = true
			time = "day"
			$Candles/MeshInstance.hide()
			$Candles2/MeshInstance2.hide()
			$CakeDecor/SpotLight.light_energy = 3.359
			$CakeDecor/SpotLight.light_color = Color(0.06, 0.62, 1.62)
			$Environment/WorldEnvironment/Day.show()
			$Environment/WorldEnvironment/Night.hide()
			$Environment/WorldEnvironment.environment = dayenv		
			daymusic = false
			SoundManager.stop("days")
			SoundManager.play_bgm("sunMenuMusic")
