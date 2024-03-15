extends Control

var questionNum : int = 1
var maxRounds : int = 3
onready var statusText = get_parent().get_node("Status")
onready var textAnim = get_parent().get_node("TextAnimation")
onready var noteAnim = get_parent().get_node("NoteAnimation")
var enabled = true

var files = ["res://Scenes/MinigameMenu/Minigames/IzcilakieMuziki/experimental/rokenrols.mid", "res://Scenes/MinigameMenu/Minigames/IzcilakieMuziki/experimental/tumanesi.mid","res://Scenes/MinigameMenu/Minigames/IzcilakieMuziki/experimental/kakugis.mid"]
var music = ["rokenrols", "tumanesi", "kakugis"]
var length = [16, 28, 20] # 20

var file_path = "res://Scenes/MinigameMenu/Minigames/IzcilakieMuziki/questions.tres"
var questions : Dictionary

func _ready():
	import_resources_data()
	print(questions)
	
func import_resources_data():
	var file = File.new()
	file.open(file_path, file.READ)
	while !file.eof_reached(): 
		var data_set = Array(file.get_csv_line(";"))
		if data_set.size() == 6:
			questions[questions.size()+1] = data_set 
	file.close()
		
func startRound():
	if (questionNum <= maxRounds):
		get_parent().get_node("MidiPlayer").file = files[questionNum-1]
		statusText.bbcode_text = "[center][wave][wave amp = 1]"+str(questionNum)+". piegājiens[/wave]"
		yield(get_tree().create_timer(2),"timeout")
		statusText.bbcode_text = "[center][wave][wave amp = 1]Uzmanību...[/wave]"
		yield(get_tree().create_timer(2),"timeout")
		statusText.bbcode_text = "[center][wave][wave amp = 1]Gatavību...[/wave]"
		yield(get_tree().create_timer(2),"timeout")
		statusText.bbcode_text = "[center][wave][wave amp = 1]Starts![/wave]"
		yield(get_tree().create_timer(1),"timeout")
		get_parent().get_node("MidiPlayer").play()
		SoundManager.play_se(music[questionNum-1])
		textAnim.play("GoAway")
		yield(get_tree().create_timer(1),"timeout")
		textAnim.play("RESET")
		yield(get_tree().create_timer(length[questionNum-1]),"timeout")
		endRound()
	else:
		get_parent().endGame()	
	pass

func endRound():
	noteAnim.play("ComeOut")
	SoundManager.play_bgm("submenu")
	$Question.bbcode_text = "[wave][wave amp=0]Jautājums #"+str(questionNum)+"[/wave]"
	$Question2.bbcode_text = "[wave][wave amp=0]"+questions[questionNum][0]+"[/wave]"
	$Ans1.text = questions[questionNum][1]
	$Ans2.text = questions[questionNum][2]
	$Ans3.text = questions[questionNum][3]
	$Ans4.text = questions[questionNum][4]
	yield(get_tree().create_timer(1.8),"timeout")
	textAnim.play("QuestionsComeIn")
	


func _on_Ans1_button_up():
	if enabled:
		if questions[questionNum][5] == "1":
			get_parent().score += 1
			$Ans1.modulate = Color(0.54, 4.07, 0.56)	
			SoundManager.play_se("victorySound")
		else:
			$Ans1.modulate = Color(2.89, 0.16, 0.16)
			get_parent().score -= 1
			SoundManager.play_se("loss")	
		disableButtons()	
	pass 


func _on_Ans1_mouse_entered():
	if enabled:
		$Ans1.modulate = Color(0.25, 0.91, 3.49)
		SoundManager.play_se("selection")
	pass # Replace with function body.


func _on_Ans1_mouse_exited():
	if enabled:
		$Ans1.modulate = Color(1.0, 1.0, 1.0)
	pass # Replace with function body.


func _on_Ans2_button_up():
	if enabled:
		if questions[questionNum][5] == "2":
			get_parent().score += 1
			$Ans2.modulate = Color(0.54, 4.07, 0.56)	
			SoundManager.play_se("victorySound")
		else:
			$Ans2.modulate = Color(2.89, 0.16, 0.16)
			get_parent().score -= 1
			SoundManager.play_se("loss")	
		disableButtons()	
	pass # Replace with function body.


func _on_Ans2_mouse_entered():
	if enabled:
		SoundManager.play_se("selection")
		$Ans2.modulate = Color(0.25, 0.91, 3.49)
	pass # Replace with function body.


func _on_Ans2_mouse_exited():
	if enabled:
		$Ans2.modulate = Color(1.0, 1.0, 1.0)
	pass # Replace with function body.


func _on_Ans4_button_up():
	if enabled:
		if questions[questionNum][5] == "4":
			get_parent().score += 1
			$Ans4.modulate = Color(0.54, 4.07, 0.56)	
			SoundManager.play_se("victorySound")
		else:
			$Ans4.modulate = Color(2.89, 0.16, 0.16)
			get_parent().score -= 1
			SoundManager.play_se("loss")	
		disableButtons()
	pass # Replace with function body.


func _on_Ans4_mouse_exited():
	if enabled:
		$Ans4.modulate = Color(1.0, 1.0, 1.0)
	pass # Replace with function body.


func _on_Ans3_button_up():
	if enabled:
		if questions[questionNum][5] == "3":
			get_parent().score += 1
			$Ans3.modulate = Color(0.54, 4.07, 0.56)	
			SoundManager.play_se("victorySound")
		else:
			$Ans3.modulate = Color(2.89, 0.16, 0.16)
			get_parent().score -= 1
			SoundManager.play_se("loss")	
		disableButtons()
	pass # Replace with function body.


func _on_Ans3_mouse_entered():
	if enabled:
		SoundManager.play_se("selection")
		$Ans3.modulate = Color(0.25, 0.91, 3.49)
	pass # Replace with function body.


func _on_Ans3_mouse_exited():
	if enabled:
		$Ans3.modulate = Color(1.0, 1.0, 1.0)
	pass # Replace with function body.


func _on_Ans4_mouse_entered():
	if enabled:
		SoundManager.play_se("selection")
		$Ans4.modulate = Color(0.25, 0.91, 3.49)
	pass # Replace with function body.

func disableButtons():
	enabled = false
	yield(get_tree().create_timer(2),"timeout")
	textAnim.play("QuestionsComeOut")
	questionNum += 1
	yield(get_tree().create_timer(3),"timeout")
	if questionNum <= maxRounds:
		SoundManager.stop("submenu")
		noteAnim.play("ComeIn")
	hide()
	enabled = true
	$Ans1.modulate = Color(1.0, 1.0, 1.0)
	$Ans2.modulate = Color(1.0, 1.0, 1.0)
	$Ans3.modulate = Color(1.0, 1.0, 1.0)
	$Ans4.modulate = Color(1.0, 1.0, 1.0)
	startRound()
	print("[POINTS] "+str(get_parent().score))
