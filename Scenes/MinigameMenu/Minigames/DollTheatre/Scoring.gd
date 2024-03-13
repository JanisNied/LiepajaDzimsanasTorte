extends Node

var Score = 0
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
		if AccCount != 0:
			Accuracy = Accuracy + ((addition - Accuracy) / AccCount)
		
		# score
		if score == 300:
			addition = 10
		elif score == 100:
			addition = 5
		elif score == 50:
			addition = 1
			
		if Combo % 4 == 0 and Combo != 0:
			addition += 5
		
		Score += addition
		
		# combo
		Combo += 1
	else:
		if AccCount != 0:
			Accuracy = Accuracy + ((0.1 - Accuracy) / AccCount)
		else:
			Accuracy = Accuracy + ((0.1 - Accuracy) / 1)
		Combo = 0
	
	get_parent().find_node("AccuracyText").text = "Prec.:\n%.2f%%" % stepify((Accuracy * 100), 0.01)
	get_parent().find_node("ComboText").text = "%dx" % Combo
	get_parent().find_node("ScoreText").text = "Punkti:\n%d" % Score

func getGrade():
	return round(Accuracy)
