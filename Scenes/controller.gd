extends Control

var chosenArcana = 0
var selectedGames : Array
var arcana0 = preload("res://Assets/fool/fool.tres")
var arcana1 = preload("res://Assets/fool/magician.tres")
var arcana2 = preload("res://Assets/fool/hp.tres")
var arcana3 = preload("res://Assets/fool/empress.tres")
var arcana4 = preload("res://Assets/fool/emperor.tres")
var arcana5 = preload("res://Assets/fool/hiero.tres")

func _ready():
	$ViewportContainer/Viewport/Spatial/AnimationPlayer.play("float")
func buttonPressAction():
	$Forward.disabled = true
	$Backward.disabled = true
	$GameTitle.bbcode_text = "[center] "+retrieveText()+" spēle:"
	
func _on_Button_button_up():
	chosenArcana += 1
	if chosenArcana > 5:
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
	$ViewportContainer/Viewport/Spatial/AnimationPlayer.play("float")
	pass


func _on_Backward_button_up():
	chosenArcana -= 1
	if chosenArcana < 0:
		chosenArcana = 5
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
	$ButtonBack.bbcode_text = "[wave][color=white]<"
	pass # Replace with function body.

func _on_Backward_mouse_exited():
	$ButtonBack.bbcode_text = "[wave]<"
	pass		
