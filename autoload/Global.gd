extends Node

var score : int = 0
var slicesEaten : int = 0
var activitiesPicked : bool = false
var returning = false

var allowedActivities = [1, 2, 3, 4, 5, 6]
var chosenActivities : Array

var discardedActivityNum : Array
var discardedActivities : Array

var availableChoices : Dictionary = {
	"DollTheatre":{
		"name":"\"Liepājas teātris\"",
		"desc":"Laipni lūdzam Liepājas leļļu teātri!\nJāspiež atstarpi dziesmas ritmā, kad rombs ir zaļš!\n\nVeiksmi!",
		"scene":"DollTheatre"
	},
	"testactivity2":{
		"name":"\"he2lp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	},
	"testactivity3":{
		"name":"\"h3elp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	},
	"testactivity4":{
		"name":"\"h4elp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	},
	"testactivity5":{
		"name":"\"he5lp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	},
	"testactivity6":{
		"name":"\"he6lp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"MinigameMenu"
	},
	"testactivity7":{
		"name":"\"he7lp\"",
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

func printAllActivities():
	var string : String = "[DEBUG] Activities:\n"
	for i in range(len(allowedActivities)):
		string += str(allowedActivities[i])+". "+chosenActivities[i]["name"]+"\n"
	print(string)
	
func endGame():
	score = 0
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

