extends ColorRect

var QuestionItems
var AnswersList
var QuestionImage
var questionNum
var imagePath
var questionList
var answerOptions
var correctOption
var pointsGot=0
func _ready():
	
	questionNum = get_parent().get_parent().rememberSmth
	get_options()
	get_question()
	get_correct()
	imagePath = "res://Assets/img/izskrien_quest"+str(questionNum+1)+".jpg"
	#x-153 y-90
	hideAll()
	QuestionItems = $VBoxContainer/QuestionName
	AnswersList = $AnswersList
	QuestionImage = $CheckpointPhoto
	#rightOrNah = $ScoreNumber
	get_node("AnswersList").fixed_column_width>0
	show_questions()
	


func show_questions():
	AnswersList.show()
	QuestionImage.show()
	AnswersList.clear()
	print(imagePath)
	QuestionImage.texture=load(imagePath)

	QuestionItems.text = questionList



	var options = answerOptions
	print(options)
	var temp=0
	for option in options:
		#get_node("AnswersList").set
		AnswersList.add_item(option)
		temp+=1
		
	  
func refresh_scene():
	questionNum = get_parent().get_parent().rememberSmth
	get_options()
	get_question()


func _on_AnswersList_item_selected(index):
	print(index,"----------",correctOption)	
	if str(index) == correctOption:
		pointsGot+=1
		print(pointsGot)
		get_parent().get_parent().get_parent().get_node("Route/RouteFollowers").boostTime+=5
		print("so cool")
		refresh_scene()
		SoundManager.play_se("IzskrienCorrect")
	else:
		SoundManager.play_se("IzskrienIncorrect")
		print("sad")
	hideAll()
	get_parent().get_parent().restart()
	get_parent().get_parent().rememberSmth+=1
	get_parent().get_parent().set_new_collision()
	refresh_scene()
func showAll():
	show()
	get_node("CheckpointPhoto").show()
	get_node("AnswersList").show()
	get_node("VBoxContainer/QuestionName").show()
	get_node("VBoxContainer").show()
func hideAll():
	hide()
	get_node("CheckpointPhoto").hide()
	get_node("AnswersList").hide()
	get_node("VBoxContainer/QuestionName").hide()
	get_node("VBoxContainer").hide()
func set_new_pos():
	var player = get_parent().get_parent().get_parent().get_node("Route/RouteFollowers/MainPlayer")
	get_parent().set_global_position(player.global_position)
func get_question():
	var f = File.new()
	var path = "res://Scenes/MinigameMenu/Minigames/IzskrienLiepaju/assets/texts/izskrienQuestions.tres"
	f.open(path,File.READ)
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
	var path = "res://Scenes/MinigameMenu/Minigames/IzskrienLiepaju/assets/texts/izskrienChoices.tres"
	f.open(path,File.READ)
	var index=0
	while index<questionNum:
		f.get_line()
		index+=1
	answerOptions = f.get_line().split(";")
	#print(answerOptions)
func get_correct():
	var f = File.new()
	var path = "res://Scenes/MinigameMenu/Minigames/IzskrienLiepaju/assets/texts/izskrienCorrect.tres"
	f.open(path, File.READ)
	var index=0
	while index<questionNum:
		f.get_line()
		index+=1
	correctOption = f.get_line()
	print(correctOption)
