extends Control
var pointsNumber
var QuestionItems
var AnswersList
var QuestionImage
var Correct
var CorrectAnswer
var doubleOrNothing=false
var points=0
var wrong = 0
var correct = 0.0
var imagePath
var questionList 
var answerOptions
var correctOption
var questionNum = 0
var invul=0

func _process(delta):
	Global.time += delta
	
func _ready():
	SoundManager.play_bgm("wayoflife")
	QuestionItems = $VBoxContainer/Question
	QuestionImage = $QuestionPicture
	Correct = $Correct
	pointsNumber = $Points
	AnswersList = $Answers

	show_questions()
	displayScore()

func displayScore():
	Correct.text = "Pareizas atbildes: " + str(correct) + "/" + str(10)
	pointsNumber.text="Punktu skaits: "+str(points)
func show_questions():
	get_question()
	get_options()
	get_correct()
	AnswersList.show()
	QuestionImage.show()
	Correct.show()
	imagePath = "res://Scenes/MinigameMenu/Minigames/Festival/assets/images/festivalsQuest"+str(questionNum+1)+".png"

	QuestionItems.text = questionList
	#print("imagePath: ", imagePath[questionNum])
	QuestionImage.texture = load(imagePath)

	var options = answerOptions
	AnswersList.clear()
	var ttt=0
	for option in options:
		AnswersList.add_item(option)
		AnswersList.set_item_tooltip_enabled(ttt,false)
		ttt+=1
		
	  # Increment index_item here after processing the current item
func show_result():
	displayScore()
	AnswersList.hide()
	QuestionImage.hide()
	Correct.show()
	get_node("bal1").hide()
	get_node("bal2").hide()
	get_node("bal3").hide()
	var percentage = round(correct/10 * 100)
	var greet
	if percentage >= 60:
		greet = "Ļoti Labi"
	else:
		greet = "Slikti!"
	QuestionItems.text = greet + " Pareizas atbildes: " + str(percentage) + " procenti!"
	Global.score += points
	Global.earnedPoints[Global.discardedActivityNum[Global.discardedActivityNum.size()-1]-1] += points
	$Confetti.show()
	SoundManager.play_se("wooo")
	if points <= 0:
		Global.queueforretry()	
	yield(get_tree().create_timer(4), "timeout")
	SoundManager.stop("wayoflife")
	Global.transition("MinigameMenu")
	

func refresh_scene():
	questionNum+=1
	if questionNum >= 10:
		show_result()
	else:
		show_questions()
		displayScore()
	


func _on_abilities_item_activated(index):
	if index==0:
		for i in range(2):
			var r = randi() %4
			while r==correctOption or get_node("Answers").is_item_disabled(r):
				r=randi()%4
			get_node("AnswersList").set_item_disabled(r,true)
			get_node("abilities").set_item_disabled(index,true)
	if index==1:
		var r = randi() %4
		while r==correctOption or get_node("Answers").is_item_disabled(r):
			r=randi()%4
		get_node("abilities").set_item_disabled(index,true)
		get_node("AnswersList").set_item_disabled(r,true)
	if index==2:
		doubleOrNothing=true
		get_node("abilities").set_item_disabled(index,true)
	if index==3:
		_on_Answers_item_selected(randi()%4)
func get_question():
	var f = File.new()
	f.open("res://Scenes/MinigameMenu/Minigames/Festival/assets/texts/festivalsQuestionList.json",File.READ)
	var index=0
	var content = f.get_as_text()
	while index<questionNum:
		f.get_line()
		index+=1
	questionList = f.get_line()
	#print(questionList,questionNum)
	f.close()
func get_options():
	var f = File.new()
	f.open("res://Scenes/MinigameMenu/Minigames/Festival/assets/texts/festivalsAnswers.json",File.READ)
	var index=0
	while index<questionNum:
		f.get_line()
		index+=1
	answerOptions = f.get_line().split(";")
	#print(answerOptions)
func get_correct():
	var f = File.new()
	f.open("res://Scenes/MinigameMenu/Minigames/Festival/assets/texts/festivalsCorrect.json",File.READ)
	var index=0
	while index<questionNum:
		f.get_line()
		index+=1
	correctOption = f.get_line()
	print(correctOption)


func _on_Answers_item_selected(index):
	if !get_node("Answers").is_item_disabled(index):
		if str(index) == correctOption:
			SoundManager.play_se("IzskrienCorrect")
			correct += 1
			if doubleOrNothing:
				points+=2
				doubleOrNothing=false
			else:
				points+=1
		else:
			SoundManager.play_se("IzskrienIncorrect")
			wrong += 1
			if invul<1:
				if doubleOrNothing:
					points-=2
					doubleOrNothing=false
				else:
					points-=1
			else:
				invul=0
		refresh_scene()
	#play error sound

func _on_bal1_pressed():
	for i in range(2):
		print("FOR")
		var r = randi() %4
		while str(r)==correctOption or get_node("Answers").is_item_disabled(r)==true:
			r=randi()%4
		get_node("Answers").set_item_disabled(r,true)
	SoundManager.play_se("pop")
	get_node("bal1").visible=false


func _on_bal2_pressed():
	var r = randi() %4

	while str(r)==correctOption or get_node("Answers").is_item_disabled(r)==true:
		r=randi()%4
	print(get_node("Answers").get_item_text(3))
	get_node("Answers").set_item_disabled(r,true)
	SoundManager.play_se("pop")
	get_node("bal2").visible=false
	

func _on_bal3_pressed():
	invul=1
	SoundManager.play_se("pop")
	get_node("bal3").visible=false
