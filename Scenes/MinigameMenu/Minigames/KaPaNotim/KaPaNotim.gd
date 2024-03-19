extends Control


var score : int = 0
var firstTime = true
var attempt = 1
var maxAttempt = 3
var img : Array = ["res://Assets/rozulaukums.png", "res://Assets/muzejs.png","res://Assets/muzikaspilseta.png"]
var used : Array 

var time = [300, 300, 300, 300]
var points = [10, 10, 10, 10]

func _ready():
	SoundManager.play_bgm("timetime")
	newRound()
	
func _process(delta):
	Global.time += delta
	if not $Timer.is_stopped():
		$Time.bbcode_text = "[center][center]Atlicis Laiks:\n"+"%02d:%02d" % [floor((int($Timer.time_left) % 3600) / 60), int($Timer.time_left) % 60]

func newRound():
	$Timer.wait_time = time[attempt-1]
	$Rounds.bbcode_text = "[center][center]Piegājiens:\n"+str(attempt)+"/"+str(maxAttempt)
	var path = img[randi() % img.size()]
	while path in used:
		path = img[randi() % img.size()]
	used.append(path)
	var image = Image.new()
	var err = image.load(path)
	if err != OK:
		print("[PUZZLE] image failed to load..")
		pass
	var texture = ImageTexture.new()
	texture.create_from_image(image, 0)
	$GameView/Board.update_background_texture(texture)

func _on_Board_moves_updated(move_count):
	$Time2.bbcode_text = "[center]Gājieni:\n"+str(move_count)
	pass # Replace with function body.


func _on_Board_game_started():
	if firstTime:
		firstTime = false
	else:
		newRound()	
	$Press.hide()
	$Timer.start()
	pass # Replace with function body.
	
func endGame():
	Global.score += score
	Global.earnedPoints[Global.discardedActivityNum[Global.discardedActivityNum.size()-1]-1] += score
	if score <= 0:
		Global.queueforretry()
	yield(get_tree().create_timer(3), "timeout")
	SoundManager.stop("timetime")
	Global.transition("MinigameMenu")
	
func _on_Board_game_won():
	$BlockGame.show()
	$Timer.stop()
	if attempt == maxAttempt:
		$Press.show()
		score += int((points[attempt-1] - ($GameView/Board.move_count * 0.02)))
		$Press.bbcode_text = "[center][center][wave]Jūs saņēmāt "+str(score)+" punktus par šo spēli!"
		endGame()
	else:
		$Press.show()
		$Press.bbcode_text = "[center][center][wave]"+str(int((points[attempt-1] - ($GameView/Board.move_count * 0.02))))+" punkti saņemti! Spiežat uz bildi lai turpinātu!"
		score += int((points[attempt-1] - ($GameView/Board.move_count * 0.02)))
		print(score) 
		attempt += 1
		yield(get_tree().create_timer(2), "timeout")
		$BlockGame.hide()	
	pass # Replace with function body.


func _on_Timer_timeout():
	if attempt == maxAttempt:
		$Press.show()
		score += -abs(points[attempt-1]/2.0)
		$Press.bbcode_text = "[center][center][wave]Laiks beidzies! "+str(-abs(points[attempt-1]/2.0))+" punkti par šo piegājienu.\n Jūs saņēmāt "+str(score)+" punktus par šo spēli!"
		$BlockGame.show()
		endGame()
	else:
		$BlockGame.show()
		$Press.show()
		score += -abs(points[attempt-1]/2.0)
		$Press.bbcode_text = "[center][center][wave] Laiks beidzies! "+str(-abs(points[attempt-1]/2.0))+" punkti! Spiežat uz bildi lai turpinātu!"
		yield(get_tree().create_timer(1), "timeout")
		$Restart.show()
	pass # Replace with function body.


func _on_Restart_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Restart.hide()
			$GameView/Board.reset_move_count()
			$GameView/Board.scramble_board()
			$GameView/Board.game_state = $GameView/Board.GAME_STATES.STARTED
			print(score) 
			attempt += 1
			$BlockGame.hide()
			$Press.hide()
			newRound()
			$Timer.start()
	pass # Replace with function body.
