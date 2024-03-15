extends Node

var score : int = 0
var time : float = 0
var slicesEaten : int = 0
var activitiesPicked : bool = false
var returning = false

var allowedActivities = [1, 2, 3, 4, 5, 6]
var chosenActivities : Array

var retryMinigameNums : Array

var earnedPoints = [0, 0, 0, 0, 0, 0]

var discardedActivityNum : Array
var discardedActivities : Array

var availableChoices : Dictionary = {
	"DollTheatre":{
		"name":"\"Liepājas leļļu teātris\"",
		"desc":"Laipni lūdzam Liepājas leļļu teātri!\nJāspiež atstarpi dziesmas ritmā, kad rombs ir zaļš!\n\nVeiksmi!",
		"scene":"DollTheatre"
	},
	"MusicianMinigame":{
		"name":"\"Liepājas izcilākie mūziķi\"",
		"desc":"Mūziķi veido mūsu pilsētu skaļāku!\nŠeit jūs spēlēsiet x ritma spēles kārtas, ar mūziķu dziesmām.\nTālāk seko jautājumi!",
		"scene":"MusicianMinigame"
	},
	"IzskrienLiepaju":{
		"name":"\"Izskrien Latviju Liepājā\"",
		"desc":"Iesaisties Latvijas izskriešanā Liepājā!\nKatru kontrolpunktu jāatbild uz jautājumiem, kuri cieši saistīti ar vietu jūsu tuvumā uz kartes!\nMēģiniet uzvarēt pret datoru!",
		"scene":"TrailingPlayer"
	},
	"testactivity4":{
		"name":"Null",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	},
	"testactivity5":{
		"name":"Null",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	},
	"testactivity6":{
		"name":"Null",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	},
	"testactivity7":{
		"name":"Null",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	}
}

func pickActivitiesRandomly():
	activitiesPicked = true
	var temp = availableChoices.duplicate(true)
	for i in allowedActivities:
		var random_key = temp.keys()[randi() % temp.size()]
		var activity = temp[random_key]
		chosenActivities.append(activity)
		temp.erase(random_key)

func getRidOfEmptyActivities():
	for i in range(6):
		if chosenActivities[i]["name"] == "Null":
			discardedActivityNum.append(allowedActivities[i])
			discardedActivities.append(chosenActivities[i])
			slicesEaten += 1
	for i in discardedActivityNum:
		if i in allowedActivities:
			allowedActivities.erase(i)
	for i in discardedActivities:
		if i in chosenActivities:
			chosenActivities.erase(i)				
					
	
func printAllActivities():
	var string : String = "[DEBUG] Activities:\n"
	for i in range(len(allowedActivities)):
		string += str(allowedActivities[i])+". "+chosenActivities[i]["name"]+"\n"
	print(string)

func sortActivities():
	if allowedActivities.size() > 1:
		var n = allowedActivities.size()
		for i in range(n - 1):
			for j in range(n - i - 1):
				if allowedActivities[j] > allowedActivities[j + 1]:     
					var temp = allowedActivities[j]
					allowedActivities[j] = allowedActivities[j + 1]
					allowedActivities[j + 1] = temp
					
					var tempActivity = chosenActivities[j]
					chosenActivities[j] = chosenActivities[j + 1]
					chosenActivities[j + 1] = tempActivity

func endGame():
	score = 0
	time = 0
	slicesEaten = 0
	activitiesPicked = false
	returning = false
	discardedActivities.clear()
	discardedActivityNum.clear()
	allowedActivities = [1, 2, 3, 4, 5, 6]
	chosenActivities.clear()
	
var fade_out_speed = 1.0
var fade_in_speed = 1.0
var fade_out_pattern = "dirt"
var fade_in_pattern = "fade"
var fade_out_smoothness = 0.1
var fade_in_smoothness = 0.1
var fade_out_inverted = false
var fade_in_inverted = false
var color = Color(0, 0, 0)
var timeout = 0.0
var clickable = false
var add_to_back = true

onready var fade_out_options = SceneManager.create_options(fade_out_speed, fade_out_pattern, fade_out_smoothness, fade_out_inverted)
onready var fade_in_options = SceneManager.create_options(fade_in_speed, fade_in_pattern, fade_in_smoothness, fade_in_inverted)
onready var general_options = SceneManager.create_general_options(color, timeout, clickable, add_to_back)

func transition(scene):
	SceneManager.validate_scene(scene)
	SceneManager.validate_pattern(fade_out_pattern)
	SceneManager.validate_pattern(fade_in_pattern)
	SceneManager.set_recorded_scene(scene)
	SceneManager.change_scene("loadscene", fade_out_options, fade_in_options, general_options)
	pass 


var izskrienPunkti : int
var izskrienUzvara : bool
