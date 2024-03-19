extends Control
var pointsNumber
var QuestionItems
var AnswersList
var QuestionImage
var RestartButton
var WrongNumber
var ScoreNumber
var CorrectAnswer
var OKButton
var doubleOrNothing=false
var points=0
var wrong = 0
var correct = 0.0
var bindex
var b1
var anim = true
var b2
var b3
var b4
var imagePath
var questionList 
var answerOptions
var correctOption
var questionNum = 0

func _process(delta):
	Global.time += delta

func _ready():
	QuestionItems = $VBoxContainer/QuestionTexts
	QuestionImage = $ImageRect
	b1 = $b1
	b2 = $b2
	b3 = $b3
	b4 = $b4
#	RestartButton = $RestartButton
	ScoreNumber = $ScoreNumber
	pointsNumber = $Points
	
	show_questions()
	displayScore()

func displayScore():
	ScoreNumber.text = "Pareizas atbildes: " + str(correct) + "/" + str(10)
	pointsNumber.text="Punktu skaits: "+str(points)
func show_questions():
	get_question()
	get_options()
	get_correct()
	b1.show()
	b2.show()
	b3.show()
	b4.show()
	QuestionImage.show()
	ScoreNumber.show()
	imagePath = "res://Scenes/MinigameMenu/Minigames/LiepajaGalvaspilseta/assets/images/galvaspilsetaQuest"+str(questionNum+1)+".png"

	QuestionItems.text = questionList
	#print("imagePath: ", imagePath[questionNum])
	QuestionImage.texture = load(imagePath)

	var options = answerOptions
	for i in range(1,5):
	
		get_node("b"+str(i)+"/VBoxContainer/RichTextLabel").bbcode_text="[center]"+options[i-1]+"[/center]"
		print(get_node("b"+str(i)+"/VBoxContainer/RichTextLabel").text)
	  # Increment index_item here after processing the current item
func show_result():
	displayScore()
	b1.hide()
	b2.hide()
	b3.hide()
	b4.hide()
	QuestionImage.hide()
	ScoreNumber.show()

	var percentage = round(correct/10 * 100)
	var greet
	if percentage >= 60:
		SoundManager.play_se("victorySound")
		$Confetti.show()
		greet = "Ļoti Labi!"
	else:
		SoundManager.play_se("loss")
		greet = "Slikti!"
	$Abilities2/Arrow.queue_free()	
	if not anim:
		$Abilities2/AnimationPlayer.play_backwards("move")
		$Abilities2/AnimationPlayer.seek(0.6, true)
		
	QuestionItems.text = ""
	$Victory.text = greet + " Pareizas atbildes: " + str(percentage) + " procenti!"
	Global.score += points
	if points <= 0:
		Global.queueforretry()
	yield(get_tree().create_timer(4), "timeout")
	Global.transition("MinigameMenu")
	
func refresh_scene():
	questionNum+=1
	if questionNum >= 10:
		show_result()
	else:
		show_questions()
		displayScore()

func check_answer(index):
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
		if doubleOrNothing:
			points-=2
			doubleOrNothing=false
		else:
			points-=1
	refresh_scene()


func _on_abilities_item_activated(index):
	if index==0:
		for i in range(2):
			var r = randi() %4+1
			while str(r)==correctOption or get_node("b"+str(r)).is_visible()==false:
				r=randi()%4+1
			get_node("b"+str(r)).hide()
			get_node("abilities").set_item_disabled(index,true)
	if index==1:
		var r = randi() %4+1
		while str(r)==correctOption or get_node("b"+str(r)).is_visible()==false:
			r=randi()%4+1
		get_node("abilities").set_item_disabled(index,true)
		get_node("b"+str(r)).hide()
	if index==2:
		doubleOrNothing=true
		get_node("abilities").set_item_disabled(index,true)
	if index==3:
		check_answer(randi()%4)


func _on_b1_pressed():
	bindex=0
	check_answer(bindex)
func _on_b2_pressed():
	bindex=1
	check_answer(bindex)
func _on_b3_pressed():
	bindex=2
	check_answer(bindex)
func _on_b4_pressed():
	bindex=3
	check_answer(bindex)
func get_question():
	var f = File.new()
	f.open("res://Scenes/MinigameMenu/Minigames/LiepajaGalvaspilseta/assets/texts/galvaspilsetaQuestionList.tres",File.READ)
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
	f.open("res://Scenes/MinigameMenu/Minigames/LiepajaGalvaspilseta/assets/texts/galvaspilsetaAnswers.tres",File.READ)
	var index=0
	while index<questionNum:
		f.get_line()
		index+=1
	answerOptions = f.get_line().split(";")
	#print(answerOptions)
func get_correct():
	var f = File.new()
	f.open("res://Scenes/MinigameMenu/Minigames/LiepajaGalvaspilseta/assets/texts/galvaspilsetaCorrect.tres",File.READ)
	var index=0
	while index<questionNum:
		f.get_line()
		index+=1
	correctOption = f.get_line()
	print(correctOption)



func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if anim:
				get_node("Abilities2/Arrow").bbcode_text = "[color=black][wave][center]>"
				get_node("Abilities2/AnimationPlayer").play("move")
				anim = false
			else:
				get_node("Abilities2/Arrow").bbcode_text = "[color=black][wave][center]<"
				$Abilities2/AnimationPlayer.play_backwards("move")
				get_node("Abilities2/AnimationPlayer").seek(0.6, true)
				anim = true	
	pass # Replace with function body.
