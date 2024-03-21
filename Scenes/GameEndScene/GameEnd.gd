extends Spatial

const file_path : String = "user://leaderboard.data"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.youwenttocustomgame = false
	SoundManager.play_bgm("mistic")
	$Camera/AnimationPlayer.play("ShowScore")
	yield(get_tree().create_timer(4.5), "timeout")
	SoundManager.play_se("impactGameEnd")
	$Stats.show()
	yield(get_tree().create_timer(0.5), "timeout")
	SoundManager.play_se("impactGameEnd")
	$Stats/Points.text = "Punkti: "+str(Global.score)+"p"
	$Stats/Points.show()
	yield(get_tree().create_timer(0.5), "timeout")
	SoundManager.play_se("impactGameEnd")
	$Punkts.text = "Uzdevumu\nPunkti\n1. "+str(Global.earnedPoints[0])+"pt\n2. "+str(Global.earnedPoints[1])+"pt\n3. "+str(Global.earnedPoints[2])+"pt\n4. "+str(Global.earnedPoints[3])+"pt\n5. "+str(Global.earnedPoints[4])+"pt\n6. "+str(Global.earnedPoints[5])+"pt\n"
	$Punkts.show()
	yield(get_tree().create_timer(0.5), "timeout")
	SoundManager.play_se("impactGameEnd")
	$Stats/Time.text = "Laiks: %02d: %02d: %02d" % [floor(int(Global.time) / 3600), floor((int(Global.time) % 3600) / 60), int(Global.time) % 60]
	$Stats/Time.show()
	yield(get_tree().create_timer(0.5), "timeout")
	SoundManager.play_se("impactGameEnd")
	$Stats/EnterName.show()
	yield(get_tree().create_timer(0.5), "timeout")
	SoundManager.play_se("impactGameEnd")
	$NameField.show()
	pass # Replace with function body.

func _process(delta):
	if $NameField/LineEdit.text != "":
		$NameField/Button.show()
	else:
		$NameField/Button.hide()	


func _on_Button_button_up():
	SoundManager.play_se("impactGameEnd")
	$Stats.hide()
	$NameField.hide()
	$Punkts.hide()
	yield(get_tree().create_timer(1), "timeout")
	SoundManager.play_se("impactGameEnd")
	$Thankyou.show()
	
	
	yield(get_tree().create_timer(4), "timeout")
	storeData($NameField/LineEdit.text, Global.time, Global.score)
	Global.endGame()
	Global.transition("menuscene")
	SoundManager.stop("mistic")
	pass # Replace with function body.
	
func storeData(name : String, time : int, points : int):
	var file = File.new()
	file.open(file_path, file.READ_WRITE)
	file.seek_end()
	file.store_string(name+";"+str(time)+";"+str(points)+"\n")
	file.close()
