extends Node

var TotalScore = 0
var Accuracy = 0
var AccCount = 0
var Combo = 0

func _on_Theatre_beatHit(score):
	# accuracy
	if (score != -1):
		var addition
		if score == 300:
			addition = 1
		elif score == 100:
			addition = 0.5
		elif score == 50:
			addition = 0.25
		
		AccCount += 1
		Accuracy = Accuracy + ((addition - Accuracy) / AccCount)
		
		# combo
		Combo += 1
	else:
		Combo = 0
	
	get_parent().find_node("AccuracyText").text = "%.2f%%" % stepify((Accuracy * 100), 0.01)
	get_parent().find_node("AccuracyText").text = "%dx" % Combo
