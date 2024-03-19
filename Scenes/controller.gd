extends Control

var chosenArcana = 0
var selectedGames : Array
var arcana0 = preload("res://Assets/fool/fool.tres")
var arcana1 = preload("res://Assets/fool/magician.tres")
var arcana2 = preload("res://Assets/fool/hp.tres")
var arcana3 = preload("res://Assets/fool/empress.tres")
var arcana4 = preload("res://Assets/fool/emperor.tres")
var arcana5 = preload("res://Assets/fool/hiero.tres")
var choiceKeys = Global.availableChoices.keys()
var limit = Global.countMinigames()
var minigameList : Array
var disallowedIndexes : Array
var lastdirection = "forward"
var maxTasks = 6


func _ready():
	SoundManager.stop("sunMenuMusic")
	SoundManager.play_bgm("betweenDoors")
	upd()
	$ViewportContainer/Viewport/Spatial/AnimationPlayer.play("float")

func updateList():
	if minigameList.empty():
		$ChosenGames.hide()
		$GameTitle2.hide()
	else:
		$ChosenGames.show()
		$GameTitle2.show()
		var new = ""
		for i in minigameList:
			new += Global.availableChoices[i]["name"]+"\n"
		$ChosenGames.text = new 	
		
func upd():
	print(minigameList.size())
	if minigameList.size() < 5:
		$Choose.bbcode_text = "[center][center][wave]Izvēlies "+str(maxTasks-minigameList.size())+" uzdevumus!"
		$Play.hide()
		$PlayB.hide()
	elif minigameList.size() == 5:
		$Play.hide()
		$PlayB.hide()
		$Choose.bbcode_text = "[center][center][wave]Izvēlies "+str(maxTasks-minigameList.size())+" uzdevumu!"
	else:
		$Choose.bbcode_text = "[center][center][wave]Varat sākt spēli!"	
		$Play.show()
		$PlayB.show()
	if chosenArcana in disallowedIndexes:
		$ButtonPlus.hide()
		$Add.hide()
		$Add.disabled = true
		
		$ButtonMinus.show()
		$Remove.show()
		$Remove.disabled = false
	else:
		$ButtonPlus.show()
		$Add.show()
		$Add.disabled = false
		
		$ButtonMinus.hide()
		$Remove.hide()
		$Remove.disabled = true	
	$GameTitle.text = Global.availableChoices[choiceKeys[chosenArcana]]["name"]
	$GameDesc.text = Global.availableChoices[choiceKeys[chosenArcana]]["desc"]
	updateList()
		
func buttonPressAction():
	$Forward.disabled = true
	$Backward.disabled = true
	$Add.disabled = true
	upd()
	
func _on_Button_button_up():
	lastdirection = "forward"
	chosenArcana += 1
	if chosenArcana > limit:
		chosenArcana = 0
	buttonPressAction()	
	animForwards(retrieveTexture())							
	pass # Replace with function body.

func animForwards(texture):
	$ViewportContainer/Viewport/Spatial/AnimationPlayer.play("changearcana")
	yield(get_tree().create_timer(0.4), "timeout")
	$ViewportContainer/Viewport/Spatial/tarot.set_surface_material(0, texture)
	yield(get_tree().create_timer(1.25), "timeout")
	$ViewportContainer/Viewport/Spatial/AnimationPlayer.play("RESET")

func animBackwards(texture):
	$ViewportContainer/Viewport/Spatial/AnimationPlayer.play("changearcanaback")
	yield(get_tree().create_timer(0.4), "timeout")
	$ViewportContainer/Viewport/Spatial/tarot.set_surface_material(0, texture)
	yield(get_tree().create_timer(1.2), "timeout")
	$ViewportContainer/Viewport/Spatial/AnimationPlayer.play("RESET")

func retrieveText():
	match chosenArcana:
		0:
			return "Pirmā"
		1:
			return "Otrā"
		2:
			return "Trešā"
		3:
			return "Ceturtā"
		4:
			return "Piektā"
		5:
			return "Sestā"
	pass
			
func retrieveTexture():
	match chosenArcana:
		0:
			return arcana0
		1:
			return arcana1
		2:
			return arcana2
		3:
			return arcana3
		4:
			return arcana4
		5:
			return arcana5
	pass		


func _on_AnimationPlayer_animation_finished(anim_name):
	$Forward.disabled = false
	$Backward.disabled = false
	$Add.disabled = false
	$ViewportContainer/Viewport/Spatial/AnimationPlayer.play("float")
	pass


func _on_Backward_button_up():
	lastdirection = "backward"
	chosenArcana -= 1
	if chosenArcana < 0:
		chosenArcana = limit
	buttonPressAction()	
	animBackwards(retrieveTexture())
	pass # Replace with function body.


func _on_Forward_mouse_entered():
	$ButtonGo.bbcode_text = "[wave][color=white]>"
	pass # Replace with function body.

func _on_Forward_mouse_exited():
	$ButtonGo.bbcode_text = "[wave]>"
	pass

func _on_Backward_mouse_entered():
	$ButtonBack.bbcode_text = "[right][wave][color=white]<"
	pass # Replace with function body.

func _on_Backward_mouse_exited():
	$ButtonBack.bbcode_text = "[right][wave]<"
	pass		


func _on_Add_button_up():
	disallowedIndexes.append(chosenArcana)
	minigameList.append(choiceKeys[chosenArcana])
	print(minigameList)
	print(disallowedIndexes)
	upd()
	yield(get_tree().create_timer(1), "timeout")
	pass # Replace with function body.


func _on_Add_mouse_entered():
	$ButtonPlus.bbcode_text = "[wave][center][center][color=white]+"
	pass # Replace with function body.


func _on_Add_mouse_exited():
	$ButtonPlus.bbcode_text = "[wave][center][center]+"
	pass # Replace with function body.


func _on_Remove_button_up():
	disallowedIndexes.erase(chosenArcana)
	minigameList.erase(choiceKeys[chosenArcana])
	print(minigameList)
	print(disallowedIndexes)
	upd()
	yield(get_tree().create_timer(1), "timeout")
	pass # Replace with function body.


func _on_Remove_mouse_entered():
	$ButtonMinus.bbcode_text = "[wave][center][center][color=white]-"
	pass # Replace with function body.


func _on_Remove_mouse_exited():
	$ButtonMinus.bbcode_text = "[wave][center][center]-"
	pass # Replace with function body.


func _on_PlayB_button_up():
	$Add.hide()
	$Remove.hide()
	$Backward.hide()
	$Forward.hide()
	$ButtonBack.hide()
	$ButtonGo.hide()
	$ButtonMinus.hide()
	$ButtonPlus.hide()
	$BackToMenu.hide()
	$Title2.hide()
	Global.activitiesPicked = true
	Global.chosenActivities = convertActivities()
	Global.transition("MinigameMenu")
	pass # Replace with function body.

func convertActivities() -> Array:
	var activities : Array
	for i in minigameList:
		activities.append(Global.availableChoices[i])
	return activities	
	
func _on_PlayB_mouse_entered():
	$Play.bbcode_text = "[wave][center][color=white]Sākt Spēli"
	pass # Replace with function body.


func _on_PlayB_mouse_exited():
	$Play.bbcode_text = "[wave][center]Sākt Spēli"
	pass # Replace with function body.


func _on_BackToMenu_button_up():
	Global.transition("menuscene")
	pass # Replace with function body.


func _on_BackToMenu_mouse_exited():
	$Title2.bbcode_text = "[center][center][wave]< Atpakaļ"
	pass # Replace with function body.


func _on_BackToMenu_mouse_entered():
	$Title2.bbcode_text = "[center][center][wave][color=white]< Atpakaļ"
	pass # Replace with function body.
