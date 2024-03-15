extends Node

var Score = 0
var Accuracy = 0
var AccCount = 0
var Combo = 0
var MaxCombo = 0

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
		if MaxCombo <= Combo:
			MaxCombo = Combo
	else:
		AccCount += 1
		Accuracy = Accuracy + ((0.1 - Accuracy) / AccCount)
		Combo = 0
	
	get_parent().find_node("AccuracyText").text = "Prec.:\n%.2f%%" % stepify((Accuracy * 100), 0.01)
	get_parent().find_node("ComboText").text = "%dx" % Combo
	get_parent().find_node("ScoreText").text = "Punkti:\n%d" % Score

func getGrade():
	var acc = round(Accuracy * 100)
	var didmaxcombo = 0
	if get_parent().find_node("Beatmap").FullCombo == Combo:
		didmaxcombo == 1
	var final = ((acc + didmaxcombo) / 11)
	
	if (Accuracy * 100) < 35.0:
		final *= -1
		
	return int(final)
