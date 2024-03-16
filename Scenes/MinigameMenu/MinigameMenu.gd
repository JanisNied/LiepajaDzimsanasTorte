extends Node2D

var holoMat = preload("res://Shaders/holo.tres")
var holoMat2 = preload("res://Shaders/holo1.tres")
var gamepad = preload("res://Assets/gamepad.png")
var gamepad1 = preload("res://Assets/gamepadselect.png")


func _ready():
	$Background/Nosaukums2.text = "Punkti: "+str(Global.score)+"pt"
	print("[TIME] Elapsed Time since Game Start: %02d:%02d:%02d" % [floor(int(Global.time) / 3600), floor((int(Global.time) % 3600) / 60), int(Global.time) % 60])
	print("[STATS] Tracked Total Score: ", Global.earnedPoints)
	SoundManager.stop("sunMenuMusic")
	randomize()
	if not Global.activitiesPicked:
		Global.pickActivitiesRandomly()
		Global.getRidOfEmptyActivities()
	Global.printAllActivities()
	repeatSlices()
	deleteEatenSlices()
	if Global.slicesEaten != 6:
		$ViewportContainer.show()
		yield(get_tree().create_timer(1.5), "timeout")
		$ViewportContainer/Viewport/Spatial/Camera/AnimationPlayer.play("CakeOpening")
		yield(get_tree().create_timer(2.55), "timeout")
		SoundManager.play_bgm("bass")
	else:
		noSlices()
	print("Current Score: "+str(Global.score))
	pass # Replace with function body.
	
func noSlices():
	Global.transition("GameEnd")
	
func deleteEatenSlices():
	for i in Global.discardedActivityNum:
		match i:
			1:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake2.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake3.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake4.set_surface_material(0, holoMat)
			2:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake5.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake6.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake8.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake9.set_surface_material(0, holoMat)
			3:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake11.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake10.set_surface_material(0, holoMat)
			4:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake2.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake3.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake4.set_surface_material(0, holoMat)
			5:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake5.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake6.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake8.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake9.set_surface_material(0, holoMat)
			6:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake11.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake10.set_surface_material(0, holoMat)

func repeatSlices():
	for i in Global.retryMinigameNums:
		if not i in Global.discardedActivityNum:
			match i:
				1:
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake2.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake3.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake4.set_surface_material(0, holoMat2)
				2:
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake5.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake6.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake8.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake9.set_surface_material(0, holoMat2)
				3:
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake11.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake10.set_surface_material(0, holoMat2)
				4:
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake2.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake3.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake4.set_surface_material(0, holoMat2)
				5:
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake5.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake6.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake8.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake9.set_surface_material(0, holoMat2)
				6:
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake11.set_surface_material(0, holoMat2)
					$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake10.set_surface_material(0, holoMat2)
func _process(delta):
	Global.time += delta


func _on_Button_mouse_entered():
	$RightArrow.modulate = Color(1.0, 0.27, 0.35)
	pass # Replace with function body.


func _on_Button_mouse_exited():
	$RightArrow.modulate = Color(1.0, 1.0, 1.0)
	pass # Replace with function body.


func _on_Button2_mouse_entered():
	$LeftArrow.modulate = Color(1.0, 0.27, 0.35)
	pass # Replace with function body.


func _on_Button2_mouse_exited():
	$LeftArrow.modulate = Color(1.0, 1.0, 1.0)
	pass # Replace with function body.


func _on_Transition_mouse_entered():
	$Gamepad.texture = gamepad1
	pass # Replace with function body.


func _on_Transition_mouse_exited():
	$Gamepad.texture = gamepad
	pass # Replace with function body.
