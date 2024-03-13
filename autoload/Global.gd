extends Node

var score : int = 0

var allowedActivities = [1, 2, 3, 4, 5, 6]
var chosenActivities : Array

var availableChoices : Dictionary = {
	"testactivity1":{
		"name":"\"help1\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"menuscene"
	},
	"testactivity2":{
		"name":"\"he2lp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"menuscene"
	},
	"testactivity3":{
		"name":"\"h3elp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"menuscene"
	},
	"testactivity4":{
		"name":"\"h4elp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"menuscene"
	},
	"testactivity5":{
		"name":"\"he5lp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"menuscene"
	},
	"testactivity6":{
		"name":"\"he6lp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"menuscene"
	},
	"testactivity7":{
		"name":"\"he7lp\"",
		"desc":"This is a description, this is a description, this is a description",
		"scene":"menuscene"
	}
}

func pickActivitiesRandomly():
	var temp = availableChoices.duplicate(true)
	for i in allowedActivities:
		var random_key = temp.keys()[randi() % temp.size()]
		var activity = temp[random_key]
		chosenActivities.append(activity)
		temp.erase(random_key)

func endGame():
	allowedActivities = [1, 2, 3, 4, 5, 6]
	chosenActivities.clear()
