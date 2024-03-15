extends Control

var questionNum : int = 1
onready var statusText = get_parent().get_node("Status")
onready var textAnim = get_parent().get_node("TextAnimation")
onready var noteAnim = get_parent().get_node("NoteAnimation")

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
	statusText.bbcode_text = "[center][wave][wave amp = 1]"+str(questionNum)+". piegājiens[/wave]"
	yield(get_tree().create_timer(2),"timeout")
	statusText.bbcode_text = "[center][wave][wave amp = 1]Uzmanību...[/wave]"
	yield(get_tree().create_timer(2),"timeout")
	statusText.bbcode_text = "[center][wave][wave amp = 1]Gatavību...[/wave]"
	yield(get_tree().create_timer(2),"timeout")
	statusText.bbcode_text = "[center][wave][wave amp = 1]Starts![/wave]"
	yield(get_tree().create_timer(1),"timeout")
	textAnim.play("GoAway")
	yield(get_tree().create_timer(1),"timeout")
	textAnim.play("RESET")
	yield(get_tree().create_timer(2),"timeout")
	endRound()
	pass

func endRound():
	noteAnim.play("ComeOut")
	$Question2.bbcode_text = "[wave][wave amp=0]"+questions[questionNum][0]+"[/wave]"
	$Ans1.text = questions[questionNum][1]
	$Ans2.text = questions[questionNum][2]
	$Ans3.text = questions[questionNum][3]
	$Ans4.text = questions[questionNum][4]
	yield(get_tree().create_timer(1.8),"timeout")
	textAnim.play("QuestionsComeIn")
	
