extends Node2D

func _ready():
	SoundManager.stop("sunMenuMusic")
	randomize()
	if not Global.activitiesPicked:
		Global.pickActivitiesRandomly()
	Global.printAllActivities()
	deleteEatenSlices()
	if Global.slicesEaten != 6:
		yield(get_tree().create_timer(1.5), "timeout")
		$ViewportContainer/Viewport/Spatial/Camera/AnimationPlayer.play("CakeOpening")
	else:
		noSlices()
	print("Current Score: "+str(Global.score))
	pass # Replace with function body.
func noSlices():
	Global.endGame()
	Global.transition("menuscene")
	
func deleteEatenSlices():
	for i in Global.discardedActivityNum:
		match i:
			1:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake2.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake3.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake4.queue_free()
			2:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake5.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake6.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake8.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake9.queue_free()	
			3:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake11.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake10.queue_free()
			4:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake2.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake3.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake4.queue_free()
			5:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake5.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake6.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake8.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake9.queue_free()	
			6:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake11.queue_free()
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake10.queue_free()
# y = -0.294
